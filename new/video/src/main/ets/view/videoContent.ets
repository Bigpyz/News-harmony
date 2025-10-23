import { PlayState, VideoItem } from '../viewModel/VideoViewModel';
import { authorView } from './authorView';
import { CommentView } from './CommentView';


@Component
export struct videoContent {
  @Link @Watch("changeIndex") swiperIndex: number;
  @Link @Watch("changeIndex") isPlay: boolean;
  @State item: VideoItem = new VideoItem();
  private barPosition: number = 0;
  @State playState: PlayState = PlayState.STOP;
  controller: VideoController = new VideoController()
  @Link isCommentPanelVisible: boolean;

  changeIndex() {
    if (this.barPosition === this.swiperIndex) {
      if (this.isPlay) {
        // 如果当前视频处于暂停状态，恢复播放；否则开始播放
        if (this.playState === PlayState.PAUSE) {
          this.resume();
        } else {
          this.play();
        }
      }
    } else {
      this.stop();
    }
  }

  play(): void {
    if (this.playState != PlayState.START) {
      this.playState = PlayState.START;
      this.controller.start();
    }
  }

  pause(): void {
    if (this.playState === PlayState.START) {
      this.playState = PlayState.PAUSE;
      this.controller.pause();
    }
  }

  resume(): void {
    if (this.playState === PlayState.PAUSE) {
      this.playState = PlayState.START;
      this.controller.start();
    }
  }

  stop(): void {
    if (this.playState != PlayState.STOP) {
      this.playState = PlayState.STOP;
      this.controller.stop();
    }
  }

  // 处理视频点击事件，切换播放/暂停状态
  onVideoClick(): void {
    if (this.playState === PlayState.START) {
      this.pause();
    } else if (this.playState === PlayState.PAUSE) {
      this.resume();
    } else if (this.playState === PlayState.STOP) {
      this.play();
    }
  }

  aboutToAppear() {

    if (this.barPosition === 0) {
      this.playState = PlayState.START;
    } else {
      this.playState = PlayState.STOP;
    }

  }

  build() {

    Stack({ alignContent: Alignment.BottomEnd }) {

      CommentView({
        item: this.item,
        onCommentClick: () => {
          this.isCommentPanelVisible = true;
        }
      })
        .zIndex(2)

      authorView({ item: this.item })
        .zIndex(3)
      Video({
        src: this.item.src,
        controller: this.controller
      })
        .objectFit(ImageFit.Fill)
        .loop(true)
        .controls(false)
        .height('100%')
        .width("100%")
        .autoPlay(this.playState === PlayState.START ? true : false)
        .onClick(() => {
          this.onVideoClick();
        })

    }

  }
}