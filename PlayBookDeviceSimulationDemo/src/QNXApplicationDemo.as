package
{
	import de.patrickheinzelmann.qnx.system.QNXApplication;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import qnx.events.QNXApplicationEvent;
	import qnx.media.QNXStageWebView;
	import qnx.system.QNXApplication;
	
	public class QNXApplicationDemo extends Sprite
	{
		CONFIG::playbook
		public var qnxApplication:qnx.system.QNXApplication;
		
		CONFIG::adl
		public var qnxApplication:de.patrickheinzelmann.qnx.system.QNXApplication
		
		public function QNXApplicationDemo()
		{
			super();
			
			// unterstützt autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			initQNXApplication();
			addEventHandlers();
			
			CONFIG::playbook{
				var supportFileTypes:Vector.<String> = qnx.system.QNXApplication.supportedFileTypes;
			}
			CONFIG::adl{
				var supportFileTypes:Vector.<String> = de.patrickheinzelmann.qnx.system.QNXApplication.supportedFileTypes;
			}
		}
		
		CONFIG::playbook
		public function initQNXApplication():void
		{
			qnxApplication = qnx.system.QNXApplication.qnxApplication;
		}
		
		CONFIG::adl
		public function initQNXApplication():void
		{
			qnxApplication = de.patrickheinzelmann.qnx.system.QNXApplication.qnxApplication;
		}
		
		public function addEventHandlers():void
		{
			qnxApplication.addEventListener(QNXApplicationEvent.LOW_MEMORY, handleLowMemory);
			qnxApplication.addEventListener(QNXApplicationEvent.SWIPE_DOWN, handleSwipeDown);
		}
		
		public function handleLowMemory(event:QNXApplicationEvent):void
		{
			trace("Playbook has low memory");	
		}
		
		public function handleSwipeDown(event:QNXApplicationEvent):void
		{
			trace("Swipe down");
			
			CONFIG::adl{
				qnxApplication.openFile("/Users/Patrick/Desktop/BuildingAIRApplications.pdf");
			}
		}
	}
}