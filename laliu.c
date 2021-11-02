 
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
 
 
    if(argc < 2){
        printf("Usage: a.out <in_file> <out_file>\n");
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
    set_block_timeout_time(get_systime() + 10000000);
    // Open an input stream and read the header, 
    if( (ret = avformat_open_input ( &pInFmtContext, in_file, NULL, NULL)) < 0){
        printf("avformat_open_input failed:%d\n",ret);         
		return -1;    
    }
    //查询输入流中的所有流信息
	if( avformat_find_stream_info(pInFmtContext, NULL) < 0){
		printf("avformat_find_stream_info failed\n");
		return -1;
	}
    //print 
	av_dump_format(pInFmtContext, 0, in_file, 0); 
 
// output ..............................
    ret = avformat_alloc_output_context2(&pOutFmtContext, NULL, NULL, out_file);
    if(ret < 0){
        printf("avformat_alloc_output_context2 filed:%d\n",ret);
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
            printf("avcodec_parameters_copy failed\n");
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
        printf("avio_open failed\n");
        return -1;
    }
 
 
    ret = avformat_write_header(pOutFmtContext, NULL);
    if( ret < 0){
        printf("avformat_write_header failed\n");
        return -1;
    }
 
    in_packet = av_packet_alloc();
 
    while(1){
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
 
    av_write_trailer(pOutFmtContext);
    av_packet_free(&in_packet);
 
    avformat_close_input(&pInFmtContext);
    avio_close( pOutFmtContext->pb);
    avformat_free_context(pOutFmtContext);
 
    printf("................end\n");
    return 0;
}
