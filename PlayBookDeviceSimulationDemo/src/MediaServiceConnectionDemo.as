package
{
	import de.patrickheinzelmann.qnx.media.MediaServiceConnection;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import qnx.events.MediaServiceConnectionEvent;
	import qnx.events.MediaServiceRequestEvent;
	import qnx.media.MediaServiceConnection;
	
	public class MediaServiceConnectionDemo extends Sprite
	{
		public var isPlaying:Boolean;
		
		CONFIG::playbook
		public var mediaServiceConnection:qnx.media.MediaServiceConnection;
		
		CONFIG::adl
		public var mediaServiceConnection:de.patrickheinzelmann.qnx.media.MediaServiceConnection;
		
		public function MediaServiceConnectionDemo()
		{
			super();
			
			// unterstützt autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			initMediaServiceConnection();
			addEventHandlers();
			mediaServiceConnection.connect();
		}
		
		CONFIG::playbook
		public function initMediaServiceConnection():void{
			mediaServiceConnection = new qnx.media.MediaServiceConnection();
		}

		CONFIG::adl
		public function initMediaServiceConnection():void{
			mediaServiceConnection = new de.patrickheinzelmann.qnx.media.MediaServiceConnection();
		}
		
		private function addEventHandlers():void
		{
			mediaServiceConnection.addEventListener(MediaServiceConnectionEvent.CONNECT, handleMediaServiceConnect);
			mediaServiceConnection.addEventListener(MediaServiceConnectionEvent.CONNECTION_FAIL, handleMediaServiceConnectionFail);
			mediaServiceConnection.addEventListener(MediaServiceConnectionEvent.DISCONNECT, handleMediaServiceDisconnect);
			mediaServiceConnection.addEventListener(MediaServiceConnectionEvent.ACCESS_CHANGE, handleMediaServiceAccessChange);
			mediaServiceConnection.addEventListener(MediaServiceRequestEvent.TRACK_NEXT, handleMediaRequestTrackNext);
			mediaServiceConnection.addEventListener(MediaServiceRequestEvent.TRACK_PAUSE, handleMediaRequestTrackPause);
			mediaServiceConnection.addEventListener(MediaServiceRequestEvent.TRACK_PLAY, handleMediaRequestTrackPlay);
			mediaServiceConnection.addEventListener(MediaServiceRequestEvent.TRACK_PREV, handleMediaRequestTrackPrev);
			
		}
		
		private function handleMediaServiceConnect(event:MediaServiceConnectionEvent):void
		{
			trace("MediaService Connected");
			mediaServiceConnection.requestAudioService();
		}
		
		private function handleMediaServiceConnectionFail(event:MediaServiceConnectionEvent):void
		{
			trace("MediaService Connection failed");
		}
		
		private function handleMediaServiceDisconnect(event:MediaServiceConnectionEvent):void
		{
			trace("MediaService disconnected");
		}
		
		private function handleMediaServiceAccessChange(event:MediaServiceConnectionEvent):void
		{
			if(mediaServiceConnection.hasAudioService()){
				isPlaying = true
				mediaServiceConnection.setPlayState(isPlaying);
				trace("MediaService Access changed: Has AudioService");
				/**
				 * Infos from Last.fm ;)
				 * http://www.lastfm.de/api/show?service=356
				 */
				var object:Object = new Object();
				object.track = "Cher - Believe";
				object.album = "The Very Best of Cher";
				object.position = 150000;
				object.duration = 239000;
				object.albumArtwork = "http://userserve-ak.last.fm/serve/300x300/41161483.png";
				mediaServiceConnection.sendMetadata(object);
			}else{
				trace("MediaService Access changed: Lost AudioService");
			}
		}
		
		private function handleMediaRequestTrackNext(event:MediaServiceRequestEvent):void
		{
			trace("MediaService request next track")
		}
		
		private function handleMediaRequestTrackPrev(event:MediaServiceRequestEvent):void
		{
			trace("MediaService request previous track")
		}
		
		private function handleMediaRequestTrackPlay(event:MediaServiceRequestEvent):void
		{
			trace("MediaService request play track")
			mediaServiceConnection.setPlayState(true);
		}
		
		private function handleMediaRequestTrackPause(event:MediaServiceRequestEvent):void
		{
			trace("MediaService request pause track")
			mediaServiceConnection.setPlayState(false);
		}
	}
}