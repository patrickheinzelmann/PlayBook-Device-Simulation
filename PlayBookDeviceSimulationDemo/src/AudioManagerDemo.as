package
{
	import de.patrickheinzelmann.qnx.system.AudioManager;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import qnx.events.AudioManagerEvent;
	import qnx.notificationManager.Notification;
	import qnx.notificationManager.NotificationInterface;
	import qnx.notificationManager.NotificationManager;
	import qnx.notificationManager.NotificationProvider;
	import qnx.system.AudioManager;
	import qnx.system.AudioOutput;
	
	public class AudioManagerDemo extends Sprite
	{
		
		CONFIG::playbook
		public var audioManager:qnx.system.AudioManager;		
		
		CONFIG::adl
		public var audioManager:de.patrickheinzelmann.qnx.system.AudioManager;
		
		public function AudioManagerDemo()
		{
			super();
			
			// unterstützt autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			initAudioManager();
			addEventHandlers();
			
			trace("Connected Input: "+audioManager.connectedInput);
			trace("Input Level: "+audioManager.getInputLevel());
			trace("Input Mute: "+audioManager.getInputMute());
			
			trace("Connected Input: "+audioManager.connectedOutput);
			trace("Output Level: "+audioManager.getOutputLevel());
			trace("Output Mute: "+audioManager.getOutputMute());
			
			trace("Bluetooth Level: "+audioManager.getOutputLevel(AudioOutput.BLUETOOTH));
			trace("HDMI Mute: "+audioManager.getOutputMute(AudioOutput.HDMI));	
				
		}
		
		CONFIG::playbook
		public function initAudioManager():void{
			audioManager = qnx.system.AudioManager.audioManager;
		}
		
		CONFIG::adl
		public function initAudioManager():void{
			audioManager = de.patrickheinzelmann.qnx.system.AudioManager.audioManager;
		}
		
		public function addEventHandlers():void
		{
			audioManager.addEventListener(AudioManagerEvent.AVAILABLE_INPUTS_CHANGED, handleAvailableInputsChanged);
			audioManager.addEventListener(AudioManagerEvent.AVAILABLE_OUTPUTS_CHANGED, handleAvailableOutputsChanged);
			audioManager.addEventListener(AudioManagerEvent.CONNECTED_INPUT_CHANGED, handleConnectedInputsChanged);
			audioManager.addEventListener(AudioManagerEvent.CONNECTED_OUTPUT_CHANGED, handleConnectedOutputsChanged);
			audioManager.addEventListener(AudioManagerEvent.INPUT_LEVEL_CHANGED, handleInputLevelChanged);
			audioManager.addEventListener(AudioManagerEvent.INPUT_MUTE_CHANGED, handleInputMuteChanged);
			audioManager.addEventListener(AudioManagerEvent.OUTPUT_LEVEL_CHANGED, handleOutputLevelChanged);
			audioManager.addEventListener(AudioManagerEvent.OUTPUT_MUTE_CHANGED, handleOutputMuteChanged);
		}
		
		public function handleAvailableInputsChanged(event:AudioManagerEvent):void
		{
			var inputs:Array = audioManager.availableInputs;
			var result:String = "";
			for(var i:int = 0; i < inputs.length; i++){
				if(result != ""){
					result += ",";
				}
				result += inputs[i];
			}
			trace("Availbale Inputs: "+result);
		}
		
		public function handleAvailableOutputsChanged(event:AudioManagerEvent):void
		{
			var outputs:Array = audioManager.availableOutputs;
			var result:String = "";
			for(var i:int = 0; i < outputs.length; i++){
				if(result != ""){
					result += ",";
				}
				result += outputs[i];
			}
			trace("Availbale Outputs: "+result);
		}
		
		public function handleConnectedInputsChanged(event:AudioManagerEvent):void
		{
			trace("Connected Input: "+event.channel);
		}
		
		public function handleConnectedOutputsChanged(event:AudioManagerEvent):void
		{
			trace("Connected Output: "+event.channel);
		}
		
		public function handleInputLevelChanged(event:AudioManagerEvent):void
		{
			trace("Input Level changed: "+event.channel);
		}
		
		public function handleInputMuteChanged(event:AudioManagerEvent):void
		{
			trace("Input Mute changed: "+event.channel);
		}
		
		public function handleOutputLevelChanged(event:AudioManagerEvent):void
		{
			trace("Output Level changed: "+event.channel);
		}
		
		public function handleOutputMuteChanged(event:AudioManagerEvent):void
		{
			trace("Output Mute changed: "+event.channel);
		}
	}
}