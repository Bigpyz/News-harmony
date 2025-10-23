




export function initializeOnStartup(): Array<VideoItem> {
  let videoDataArray: Array<VideoItem> = [];
  VIDEO_DATA.forEach((item: VideoItem) => {
    videoDataArray.push(item);
  })
  return videoDataArray;
}


@Observed
export class VideoItem {
  id: string = '';
  src: Resource = $rawfile('oUCLBC9D7aJb4trcmAgsmIYfQAzKsSnje25BeC.MP4');
  likesCount: number = 0;
  isLikes: boolean = false;
  commentCount: number = 102;
  shareTimes: number = 630;
  favor: number = 78;
  author:string = '';
  label:string = '';
  music:string = '';
}


export const VIDEO_DATA: VideoItem[] = [
  {
    id: '1',
    src: $rawfile('1.mp4'),
    likesCount: 0,
    isLikes: false,
    commentCount: 51,
    shareTimes: 632,
    favor:  8,
    author:'央视新闻',
    label:"外交部回应高市早苗当选日本首相：望日方同中方相向而行。",
    music:""
  },
  {
    id: '2',
    src: $rawfile('2.mp4'),
    likesCount: 234,
    isLikes: true,
    commentCount: 0,
    shareTimes: 1,
    favor:  42,
    author:'央视新闻',
    label:"蛋挞不要加果酱”“蛋炒饭多做几次”…河南长垣一小学召开校长听证会，24名各班代表针对衣食住行充分发表意见。网友：小小的烦恼也值得被重视！",
    music:"ssssss百分比^^^^^^^^^^^^^^^^^^^^"
  },
  {
    id: '3',
    src: $rawfile('3.mp4'),
    likesCount: 8654,
    isLikes: false,
    commentCount: 4,
    shareTimes: 0,
    favor:  0,
    author:'央视新闻',
    label:"当学生满口“包的包的”网络梗，语文老师耐心引导解释：“喜欢说这些话是偷懒的人，我们要做好中国人，说好中国话。”网友：这波引导很关键",
    music:"数量~~~~~~~~~~~8888888"
  },
  {
    id: '3',
    src: $rawfile('4.mp4'),
    likesCount: 8654,
    isLikes: false,
    commentCount: 4,
    shareTimes: 0,
    favor:  0,
    author:'央视新闻',
    label:"自带“返程票”的火箭来了！可重复使用火箭朱雀三号进入首飞关键准备阶段，为今年正式入轨发射及一级回收开展各项准备。期待朱雀三号飞向太空！",
    music:"数量~~~~~~~~~~~8888888"
  }
];

/**
 * state of video play.
 */
export enum PlayState {
  STOP = 0,
  START = 1,
  PAUSE = 2
}