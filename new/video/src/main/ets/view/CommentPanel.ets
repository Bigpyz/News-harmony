import { VideoItem } from '../viewModel/VideoViewModel';

// 评论数据模型
export class CommentItem {
  id: string = '';
  avatar: string = '';
  username: string = '';
  content: string = '';
  time: string = '';
  likeCount: number = 0;
  isLiked: boolean = false;
}

@Component
export struct CommentPanel {
    @State videoItem: VideoItem = new VideoItem();
  @Link isVisible: boolean;
  @State commentText: string = '';
  @State comments: CommentItem[] = [];

  aboutToAppear() {
    // 初始化评论数据
    this.comments = [
      new CommentItem(),
      new CommentItem(),
      new CommentItem(),
      new CommentItem(),
      new CommentItem()
    ];

    // 设置第一条评论数据
    this.comments[0].id = '1';
    this.comments[0].avatar = '';
    this.comments[0].username = '小明同学';
    this.comments[0].content = '这个视频太棒了！学到了很多东西';
    this.comments[0].time = '2分钟前';
    this.comments[0].likeCount = 12;
    this.comments[0].isLiked = false;

    // 设置第二条评论数据
    this.comments[1].id = '2';
    this.comments[1].avatar = '';
    this.comments[1].username = '爱学习的小红';
    this.comments[1].content = '讲解得很清楚，感谢';
    this.comments[1].time = '5分钟前';
    this.comments[1].likeCount = 8;
    this.comments[1].isLiked = true;

    // 设置第三条评论数据
    this.comments[2].id = '3';
    this.comments[2].avatar = '';
    this.comments[2].username = '技术达人';
    this.comments[2].content = '有没有相关的资料可以分享一下？';
    this.comments[2].time = '10分钟前';
    this.comments[2].likeCount = 3;
    this.comments[2].isLiked = false;

    // 设置第四条评论数据
    this.comments[3].id = '4';
    this.comments[3].avatar = '';
    this.comments[3].username = '编程小白';
    this.comments[3].content = '作为新手，这个视频对我帮助很大';
    this.comments[3].time = '15分钟前';
    this.comments[3].likeCount = 15;
    this.comments[3].isLiked = false;

    // 设置第五条评论数据
    this.comments[4].id = '5';
    this.comments[4].avatar = '';
    this.comments[4].username = '前端工程师';
    this.comments[4].content = '期待更多这样的教程视频';
    this.comments[4].time = '20分钟前';
    this.comments[4].likeCount = 6;
    this.comments[4].isLiked = false;
  }

  // 发送评论
  sendComment() {
    if (this.commentText.trim()) {
      const newComment: CommentItem = {
        id: Date.now().toString(),
        avatar: '',
        username: '我',
        content: this.commentText,
        time: '刚刚',
        likeCount: 0,
        isLiked: false
      };
      this.comments.unshift(newComment);
      this.videoItem.commentCount++;
      this.commentText = '';
    }
  }

  // 点赞评论
  toggleLike(comment: CommentItem) {
    comment.isLiked = !comment.isLiked;
    if (comment.isLiked) {
      comment.likeCount++;
    } else {
      comment.likeCount--;
    }
  }

  build() {
    Column() {
      // 顶部标题栏
      Row() {
        Text(`${this.videoItem.commentCount} 条评论`)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('✕')
          .fontSize(20)
          .fontColor(Color.Gray)
          .onClick(() => {
            this.isVisible = false;
          })
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 15, bottom: 10 })
      .backgroundColor(Color.White)

      // 分割线
      Divider()
        .color('#F0F0F0')
        .strokeWidth(1)

      // 评论列表
      List({ space: 0 }) {
        ForEach(this.comments, (comment: CommentItem) => {
          ListItem() {
            Row({ space: 12 }) {
              // 头像
              Image($r('app.media.head_Norma'))
                .width(36)
                .height(36)
                .borderRadius(18)
                .backgroundColor('#F5F5F5')

              // 评论内容区域
              Column({ space: 6 }) {
                Row() {
                  Text(comment.username)
                    .fontSize(13)
                    .fontColor('#666666')
                    .fontWeight(FontWeight.Medium)

                  Blank()

                  Text(comment.time)
                    .fontSize(12)
                    .fontColor('#999999')
                }
                .width('100%')

                Text(comment.content)
                  .fontSize(14)
                  .fontColor('#333333')
                  .lineHeight(20)
                  .maxLines(3)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })

                // 点赞按钮
                Row({ space: 4 }) {
                  Image(comment.isLiked ? $r('app.media.digg_heart_selected_icon_32_Normal') : $r('app.media.audio_detail_action_like_seleted_Normal'))
                    .width(16)
                    .height(16)
                    .fillColor(comment.isLiked ? '#FF6B6B' : '#999999')

                  if (comment.likeCount > 0) {
                    Text(comment.likeCount.toString())
                      .fontSize(12)
                      .fontColor(comment.isLiked ? '#FF6B6B' : '#999999')
                  }
                }
                .onClick(() => {
                  this.toggleLike(comment);
                })
                .alignSelf(ItemAlign.End)
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .padding({ left: 20, right: 20, top: 15, bottom: 15 })
            .alignItems(VerticalAlign.Top)
          }
        })
      }
      .layoutWeight(1)
      .layoutWeight(1)
      .layoutWeight(1)
      .backgroundColor(Color.White)
      .divider({
        strokeWidth: 1,
        color: '#F8F8F8',
        startMargin: 68,
        endMargin: 20
      })

      // 底部输入框
      Row({ space: 12 }) {
        TextInput({
          placeholder: '说点什么...',
          text: this.commentText
        })
          .layoutWeight(1)
          .backgroundColor('#F8F8F8')
          .borderRadius(20)
          .padding({ left: 16, right: 16 })
          .height(40)
          .fontSize(14)
          .onChange((value: string) => {
            this.commentText = value;
          })

        Button('发送')
          .backgroundColor(this.commentText.trim() ? '#007AFF' : '#CCCCCC')
          .fontColor(Color.White)
          .fontSize(14)
          .borderRadius(20)
          .height(40)
          .padding({ left: 16, right: 16 })
          .enabled(this.commentText.trim().length > 0)
          .onClick(() => {
            this.sendComment();
          })
      }
      .padding({ left: 20, right: 20, top: 12, bottom: 20 })
      .width('100%')
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('60%')
    .backgroundColor(Color.White)
    .borderRadius({ topLeft: 20, topRight: 20 })
    .shadow({
      radius: 20,
      color: 'rgba(0,0,0,0.1)',
      offsetY: -5
    })
  }
}
