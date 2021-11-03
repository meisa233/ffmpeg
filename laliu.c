#include "laliu.h"
#include <stddef.h>
#include <stdlib.h>
#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>

#if HAVE_SYS_SELECT_H
#include <sys/select.h>
#endif

#if HAVE_TERMIOS_H
#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/time.h>
#include <termios.h>
#elif HAVE_KBHIT
#include <conio.h>
#endif

static int64_t s_time = 0;
static int64_t last_time = -1;

static int read_key(void)
{
    unsigned char ch;
#if HAVE_TERMIOS_H
    int n = 1;
    struct timeval tv;
    fd_set rfds;

    FD_ZERO(&rfds);
    FD_SET(0, &rfds);
    tv.tv_sec = 0;
    tv.tv_usec = 0;
    n = select(1, &rfds, NULL, NULL, &tv);
    if (n > 0) {
        n = read(0, &ch, 1);
        if (n == 1)
            return ch;

        return n;
    }
#elif HAVE_KBHIT
#    if HAVE_PEEKNAMEDPIPE
    static int is_pipe;
    static HANDLE input_handle;
    DWORD dw, nchars;
    if(!input_handle){
        input_handle = GetStdHandle(STD_INPUT_HANDLE);
        is_pipe = !GetConsoleMode(input_handle, &dw);
    }

    if (is_pipe) {
        /* When running under a GUI, you will end here. */
        if (!PeekNamedPipe(input_handle, NULL, 0, NULL, &nchars, NULL)) {
            // input pipe may have been closed by the program that ran ffmpeg
            return -1;
        }
        //Read it
        if(nchars != 0) {
            read(0, &ch, 1);
            return ch;
        }else{
            return -1;
        }
    }
#    endif
    if(kbhit())
        return(getch());
#endif
    return -1;
}

static int check_keyboard_interaction(int64_t cur_time){
    static int64_t last_time;
    int key;
    //printf("cur_time - last_time = %ld\n", cur_time - last_time);
    if(cur_time - last_time >= 100000){
        key = read_key();
        //printf("cur_time - last_time >= 100000\n");
        //printf("%c\n", key);
        last_time = cur_time;
    }else
    {key = -1;}
    
    if (key == 'q'){
        //printf("bingo!");
        return -1;
    }
    return 0;
}

void set_block_timeout_time(int64_t time)
{
    s_time = time;
}

int64_t get_systime()
{
    int64_t time;
    static int64_t start_time = 0;
    int64_t now_time;
    if(start_time == 0){
        start_time = av_gettime();
        return 0;
    }
    now_time = av_gettime();
    time = now_time - start_time;
    return time;
}

static int interrupt_cb(void * arg)
{
    if( get_systime() > s_time){
        printf("time out:%lld,%lld\n", s_time, get_systime());
        return 1;
    }
    return 0;
}
int main(int argc, char * argv[])
{    

    AVFormatContext *pInFmtContext = NULL;    
    AVStream *in_stream;
    
    AVCodecContext *pInCodecCtx;
    AVCodec *pInCodec;
    AVPacket *in_packet;


    AVFormatContext * pOutFmtContext;
    AVOutputFormat *outputFmt;
    AVStream * out_stream;
    //AVCodecContext * pOutCodecCtx;
    //AVCodec *pOutCodec;
    //AVPacket *out_packet; 
    //AVFrame *pOutFrame;
    AVRational frame_rate; 
    double duration;
    
	//int picture_size = 0;
    //FILE *fp; 
    int ret;
    const char * default_url = "rtmp://localhost:1935/live/tuiliu1";
    char in_file[128] = {0};
    char out_file[256] = {0};
    
    int videoindex = -1;
    int audioindex = -1;
    int video_frame_count = 0;
    int audio_frame_count = 0;
    int video_frame_size = 0;
	int audio_frame_size = 0;
    int i;
    int got_picture;

    static int64_t last_time;
    if(argc < 2){
        printf("Usage: a.out <in_file> <out_file>");
        return -1;
    }
    strcpy(in_file, argv[1]);
    strcpy(out_file, argv[2]);
    
    //av_register_all();
    //avformat_network_init();

// input ....................
    pInFmtContext = avformat_alloc_context();
    pInFmtContext->interrupt_callback.callback = interrupt_cb;
    pInFmtContext->interrupt_callback.opaque = pInFmtContext;
    set_block_timeout_time(get_systime() + 5 * 1000000);
    // Open an input stream and read the header, 
    if( (ret = avformat_open_input ( &pInFmtContext, in_file, NULL, NULL)) < 0){
        printf("avformat_open_input failed:%d",ret);         
		return -1;    
    }
    //查询输入流中的所有流信息
	if( avformat_find_stream_info(pInFmtContext, NULL) < 0){
		printf("avformat_find_stream_info failed");
		return -1;
	}
    //print 
	av_dump_format(pInFmtContext, 0, in_file, 0); 
	
// output ..............................
    ret = avformat_alloc_output_context2(&pOutFmtContext, NULL, NULL, out_file);
    if(ret < 0){
        printf("avformat_alloc_output_context2 filed:%d",ret);
        return -1;
    }

    for(i=0; i < pInFmtContext->nb_streams; i++){
        in_stream = pInFmtContext->streams[i];
        if(in_stream->codecpar->codec_type == AVMEDIA_TYPE_VIDEO){
            videoindex = i;
        }
        if(in_stream->codecpar->codec_type == AVMEDIA_TYPE_AUDIO){
            audioindex = i;
        }

        pInCodec = avcodec_find_decoder(in_stream->codecpar->codec_id);
        out_stream = avformat_new_stream(pOutFmtContext, pInCodec);

        ret = avcodec_parameters_copy(out_stream->codecpar, in_stream->codecpar);
        if(ret < 0){
            printf("avcodec_parameters_copy failed");
            return -1;
        }
        out_stream->codecpar->codec_tag = 0;
        
        if( pOutFmtContext->oformat->flags & AVFMT_GLOBALHEADER){
            out_stream->codec->flags |= AV_CODEC_FLAG_GLOBAL_HEADER;
        }

    }

    av_dump_format(pOutFmtContext, NULL, out_file, 1);
    ret = avio_open(&pOutFmtContext->pb, out_file, AVIO_FLAG_WRITE);
    if(ret < 0){
        printf("avio_open failed");
        return -1;
    }


    ret = avformat_write_header(pOutFmtContext, NULL);
    if( ret < 0){
        printf("avformat_write_header failed");
        return -1;
    }

    in_packet = av_packet_alloc();
    last_time = get_systime();

    while(1){
        int64_t cur_time = get_systime();
        //printf("cur_time is %ld\n", cur_time);
        if (check_keyboard_interaction(cur_time) < 0)
            break;
        set_block_timeout_time(get_systime() + 2000000);
        ret = av_read_frame(pInFmtContext, in_packet);
        if(ret < 0)
            break;

        in_stream = pInFmtContext->streams[in_packet->stream_index];
        out_stream = pOutFmtContext->streams[in_packet->stream_index];

        av_packet_rescale_ts(in_packet, in_stream->time_base, out_stream->time_base);

        if(in_packet->stream_index == videoindex){
            video_frame_size += in_packet->size;
            printf("recv %5d video frame %5d-%5d\n", ++video_frame_count, in_packet->size, video_frame_size);
        }

        
        if(in_packet->stream_index == audioindex){
            audio_frame_size += in_packet->size;
            printf("recv %5d audio frame %5d-%5d\n", ++audio_frame_count, in_packet->size, audio_frame_size);
        }

        ret = av_interleaved_write_frame(pOutFmtContext, in_packet);
        if(ret < 0){
            printf("av_interleaved_write_frame failed\n");
            break;
        }
        av_packet_unref(in_packet);

    }

end:
    av_write_trailer(pOutFmtContext);
    av_packet_free(&in_packet);

    avformat_close_input(&pInFmtContext);
    avio_close( pOutFmtContext->pb);
    avformat_free_context(pOutFmtContext);

    printf("................end\n");
   
    return 0;
}

