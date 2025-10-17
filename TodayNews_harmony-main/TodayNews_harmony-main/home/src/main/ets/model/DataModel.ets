

export class DataModel {
  media_name: string = '';
  ban_comment: number = 0;
  abstract: string = '';
  image_list: ImageList[] = [];
  image_url: string = '';
  large_image_url: string = '';
  datetime: string = '';
  article_type: number = 0;
  more_mode: boolean = false;
  middle_mode: boolean = false;
  large_mode: boolean = false;
  tag: string = '';
  has_m3u8_video: number = 0;
  display_dt: number = 0;
  has_mp4_video: number = 0;
  aggr_type: number = 0;
  cell_type: number = 0;
  article_sub_type: number = 0;
  bury_count: number = 0;
  title: string = '';
  source_icon_style: number = 0;
  tip: number = 0;
  has_video: boolean = false;
  share_url: string = '';
  label: string = '';
  source: string = '';
  comment_count: number = 0;
  article_url: string = '';
  publish_time: number = 0;
  group_flags: number = 0;
  has_image: boolean = false;
  action_extra: ActionExtra = new ActionExtra();
  tag_id: string = '';
  source_url: string = '';
  display_url: string = '';
  is_stick: boolean = false;
  item_id: string = '';
  repin_count: number = 0;
  cell_flag: number = 0;
  source_open_url: string = '';
  level: number = 0;
  digg_count: number = 0;
  behot_time: number = 0;
  hot: number = 0;
  cursor: number = 0;
  url: string = '';
  like_count: number = 0;
  user_repin: number = 0;
  label_style: number = 0;
  video_style: number = 0;
  media_info: MediaInfo = new MediaInfo();
  group_id: string = '';
}

export class ActionExtra {
  channel_id: number = 0;
}

export class MediaInfo {
  avatar_url: string = "";
  name: string = '';
  media_id: number = 0;
  user_verified: boolean = false;
}

export class ImageList {
  url: string = '';
  width: string = '';
  height: number = 0;
}

