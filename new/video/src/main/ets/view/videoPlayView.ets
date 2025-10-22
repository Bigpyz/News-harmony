
import { PlayState, VideoItem } from '../viewModel/VideoViewModel';
import { videoContent } from './videoContent';
import { CommentPanel } from './CommentPanel';


@Component
export struct  videoPlayView {
  @State swiperIndex: number = 0;
  @Link videoArray: Array<VideoItem>;

  @Link play: boolean;
  @State isCommentPanelVisible: boolean = false;

  build(){

    Stack() {
      Swiper(){
        ForEach(this.videoArray,(videos:VideoItem,index:number)=>{
          videoContent({
            swiperIndex:$swiperIndex,
            item:videos,
            barPosition:index,
            isPlay:$play,
            isCommentPanelVisible: $isCommentPanelVisible
          })
        },(videos: VideoItem)=>JSON.stringify(videos))
      }
      .width("100%")
      .height("100%")
      .indicator(false)
      .loop(false)
      .vertical(true)
      .onChange((swiper: number) => {
        this.swiperIndex = swiper;
      })

      if (this.isCommentPanelVisible) {
        CommentPanel({
          videoItem: this.videoArray[this.swiperIndex],
          isVisible: $isCommentPanelVisible
        })
        .transition(TransitionEffect.translate({ y: '100%' }))
        .position({ x: 0, y: '40%' })
        .zIndex(999)
      }
    }
    .width('100%')
    .height('100%')


  }

}