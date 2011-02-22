package
{
	import de.patrickheinzelmann.qnx.system.Device;
	
	import flash.display.Sprite;
	
	import qnx.events.DeviceBatteryEvent;
	import qnx.system.Device;
	import qnx.system.DeviceBatteryState
	
	public class DeviceDemo extends Sprite
	{
		CONFIG::playbook
		public var device:qnx.system.Device;		
		
		CONFIG::adl
		public var device:de.patrickheinzelmann.qnx.system.Device;
		
		public function DeviceDemo()
		{
			super();
			
			initDevice();
			addEventHandlers();
			
			trace(device.batteryState);
			trace(device.batteryLevel);
			device.batteryMonitoringEnabled = true;
			trace(device.batteryState);
			trace(device.batteryLevel);
		}
		
		CONFIG::playbook
		public function initDevice():void{
			device = qnx.system.Device.device;
		}
		
		CONFIG::adl
		public function initDevice():void{
			device = de.patrickheinzelmann.qnx.system.Device.device;
		}
		
		public function addEventHandlers():void
		{
			device.addEventListener(DeviceBatteryEvent.LEVEL_CHANGE, handleBatteryLevelChanged);
			device.addEventListener(DeviceBatteryEvent.STATE_CHANGE, handleBatteryStateChanged);
		}
		
		private function handleBatteryLevelChanged(event:DeviceBatteryEvent):void{
			trace("Current Battery Level: "+event.batteryLevel+"%");
		}
		
		private function handleBatteryStateChanged(event:DeviceBatteryEvent):void{
			switch(event.batteryState){
				case DeviceBatteryState.UNKNOWN:
					trace("The state of the device battery is unknown: Battery Monitoring is disabled");
					break;
				case DeviceBatteryState.CHARGING:
					trace("Device is charging: "+event.batteryLevel+"%");
					break;
				case DeviceBatteryState.UNPLUGGED:
					trace("Device is discharging and battery is unplugged from power: "+event.batteryLevel+"%");
					break;
				case DeviceBatteryState.FULL:
					trace("Device is fully loaded: "+event.batteryLevel+"%");
					break;
			}
			
		}
	}
}