package
{
	import de.patrickheinzelmann.qnx.system.QNXApplication;
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import qnx.events.QNXApplicationEvent;
	import qnx.events.QNXSystemEvent;
	import qnx.media.QNXStageWebView;
	import qnx.system.QNXApplication;
	import qnx.system.QNXSystem;
	import qnx.system.QNXSystemPowerMode;
	import qnx.system.QNXSystemResource;
	
	public class QNXSystemDemo extends Sprite
	{
		CONFIG::playbook
		public var qnxSystem:qnx.system.QNXSystem;
		
		CONFIG::adl
		public var qnxSystem:de.patrickheinzelmann.qnx.system.QNXSystem;
		
		public var alarmId:int;
		
		public var app:NativeApplication
		
		public function QNXSystemDemo()
		{
			super();
			
			// unterstützt autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			initQNXSystem();
			addEventHandlers();

			qnxSystem.requestResource(QNXSystemResource.ACCELEROMETER);
			qnxSystem.requestResource(QNXSystemResource.GEOLOCATION);
			qnxSystem.requestResource(QNXSystemResource.NETWORKING);
			trace("System State: "+qnxSystem.systemState);
			trace("Power Mode: "+qnxSystem.powerMode);
			trace("Inactive Power Mode: "+qnxSystem.inactivePowerMode);
			trace("Transition Time: "+qnxSystem.transitionTime);
			alarmId = qnxSystem.setAlarm(1000*60, true);
			
			app = NativeApplication.nativeApplication;
			app.addEventListener(Event.ACTIVATE, handleApplicationActivate);
			app.addEventListener(Event.DEACTIVATE, handleApplicationDeactivate);
		}

		private function handleApplicationActivate(event:Event):void
		{
			if(qnxSystem.transitionTime == 0){
				qnxSystem.transitionTime = 300;
			}else{
				qnxSystem.transitionTime = 0;
			}
		}
		
		private function handleApplicationDeactivate(event:Event):void
		{
			trace(qnxSystem.powerMode);
			qnxSystem.inactivePowerMode = QNXSystemPowerMode.THROTTLED;
		}
		
		CONFIG::playbook
		public function initQNXSystem():void
		{
			qnxSystem = qnx.system.QNXSystem.system;
		}
		
		CONFIG::adl
		public function initQNXSystem():void
		{
			qnxSystem = de.patrickheinzelmann.qnx.system.QNXSystem.system;
		}
		
		public function addEventHandlers():void
		{
			qnxSystem.addEventListener(QNXSystemEvent.ACTIVE, handleActive);
			qnxSystem.addEventListener("inactive", handleInactive);
			qnxSystem.addEventListener(QNXSystemEvent.STANDBY, handleStandBy);
			qnxSystem.addEventListener(QNXSystemEvent.ALARM, handleAlarm);
		}

		private function handleAlarm(event:QNXSystemEvent):void
		{
			checkResources();
			qnxSystem.cancelAlarm(alarmId);
			qnxSystem.releaseResource(QNXSystemResource.ACCELEROMETER);
			checkResources();
			qnxSystem.releaseResource(QNXSystemResource.GEOLOCATION);
			checkResources();
			qnxSystem.releaseResource(QNXSystemResource.NETWORKING);
			checkResources();
		}
		
		public function handleActive(event:QNXSystemEvent):void
		{
			trace("System Status: Active");	
		}
		
		public function handleInactive(event:QNXSystemEvent):void
		{
			trace("System Status: Inactive");	
		}
		
		public function handleStandBy(event:QNXSystemEvent):void
		{
			trace("System Status: StandBy");
		}
		
		public function checkResources():void
		{
			var resources:Object = qnxSystem.getResources();
			
			if(resources.accelerometer is Boolean){
				if(resources.accelerometer){
					trace("Has Resource Accelerometer");
				}
			}else{
				trace("Hasn't Resource Accelerometer");
			}
			
			if(resources.geolocation is Boolean){
				if(resources.geolocation){
					trace("Has Resource Geolocation");
				}
			}else{
				trace("Hasn't Resource Geolocation");
			}
			
			if(resources.networking is Boolean){
				if(resources.networking){
					trace("Has Resource Networking");
				}
			}else{
				trace("Hasn't Resource Networking");
			}
		}
	}
}