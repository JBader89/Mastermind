package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	
//	[SWF(width="1500", height="800")]
	
	public class MasterMind extends Sprite
	{
		private var mindArray:Array;
		private var movingRed:Sprite=new Sprite();
		private var movingOrange:Sprite=new Sprite();
		private var movingYellow:Sprite=new Sprite();
		private var movingGreen:Sprite=new Sprite();
		private var movingPurple:Sprite=new Sprite();
		private var playerMoving:Boolean=false;
		private var fullBox:Boolean=false;
		private var guessesLeft:uint=10;
		private var selector:Sprite=new Sprite();
		private var chosenColor:uint=0;
		private var chosenColor2:uint=0;
		private var correctCounter:uint=0;
		private var cover:Sprite=new Sprite();
		private var colorsTimer:Timer=new Timer(250);
		private var colorHolder:Sprite=new Sprite();
		public function MasterMind()
		{
			selector.graphics.lineStyle(1,0xffffff,0.3);
			selector.graphics.beginFill(0xffffff,0.3);
			selector.graphics.drawRect(1,1,28,28);
			selector.graphics.endFill();
			selector.mouseEnabled=false;
			setupGrid();
			drawGrid();
			compChoice();
			addChild(selector);
			hideAnswer();
			drawColors();
			dropColors();
			addText();
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		private function setupGrid():void{
			mindArray = new Array();
			for (var i:uint=0; i<11; i++){
				mindArray[i]=new Array();
				for (var j:uint=0; j<5; j++){
					mindArray[i][j]=0;
				}
			}
		}
		private function drawGrid():void{
			var gridSprite:Sprite=new Sprite();
			addChild(gridSprite);
			for (var i:uint=0; i<11; i++){
				for (var j:uint=0; j<5; j++){
					gridSprite.graphics.lineStyle(1,0x000000);
					gridSprite.graphics.beginFill(0x008CFF);
					gridSprite.graphics.drawRect(180+30*j,20+30*i,30,30);
				}
			}
		}
		private function addText():void{
			var instructText:TextField=new TextField;
			instructText.text="Fill the first four columns with the four"
			instructText.textColor=0x008CFF;
			instructText.height=20;
			instructText.width=200
			instructText.x=345;
			instructText.y=50;
			addChild(instructText);
			var instructText2:TextField=new TextField;
			instructText2.text="colors on the left to guess the code."
			instructText2.textColor=0x008CFF;
			instructText2.height=20;
			instructText2.width=200
			instructText2.x=345;
			instructText2.y=65; 
			addChild(instructText2);
			var instructText3:TextField=new TextField;
			instructText3.text=": correct color, correct spot."
			instructText3.textColor=0x008CFF;
			instructText3.height=20;
			instructText3.width=200
			instructText3.x=355;
			instructText3.y=20; 
			addChild(instructText3);
			var instructText4:TextField=new TextField;
			instructText4.text=": correct color, wrong spot."
			instructText4.textColor=0x008CFF;
			instructText4.height=20;
			instructText4.width=200
			instructText4.x=355;
			instructText4.y=35; 
			addChild(instructText4);
			var instructText5:TextField=new TextField;
			instructText5.text="You can click on the falling colors for"
			instructText5.textColor=0x008CFF;
			instructText5.height=20;
			instructText5.width=200
			instructText5.x=345;
			instructText5.y=80; 
			addChild(instructText5);
			var instructText6:TextField=new TextField;
			instructText6.text="some added entertainment. Have fun!"
			instructText6.textColor=0x008CFF;
			instructText6.height=20;
			instructText6.width=200
			instructText6.x=345;
			instructText6.y=95; 
			addChild(instructText6);
			var legendChoice:Sprite=new Sprite();
			legendChoice.graphics.lineStyle(1,0x000000);
			legendChoice.graphics.beginFill(0xFF0000);
			legendChoice.graphics.drawCircle(350,27.5,4);
			addChild(legendChoice);
			var legendChoice2:Sprite=new Sprite();
			legendChoice2.graphics.lineStyle(1,0x000000);
			legendChoice2.graphics.beginFill(0xFFFFFF);
			legendChoice2.graphics.drawCircle(350,42.5,4);
			addChild(legendChoice2);
			var title:TextField=new TextField;
			title.text="Mastermind";
			title.textColor=0x008CFF;
			title.height=20;
			title.width=200
			title.x=542.5;
			title.y=322.5; 
			addChild(title);
			var signature:TextField=new TextField;
			signature.text="By Jeremy Bader"
			signature.textColor=0x008CFF;
			signature.height=20;
			signature.width=200
			signature.x=530;
			signature.y=337.5; 
			addChild(signature);
		}
		private function compChoice():void{
			for (var i:uint=0; i<4; i++){
				mindArray[10][i]=Math.floor(Math.random()*5)+1;
				if (mindArray[10][i]==1){
					var compRed:Sprite=new Sprite();
					compRed.graphics.lineStyle(1,0x000000);
					compRed.graphics.beginFill(0xFF0000);
					compRed.graphics.drawCircle(i*30+195,(10*30+35),10);
					addChild(compRed);
				}
				else if (mindArray[10][i]==2){
					var compOrange:Sprite=new Sprite();
					compOrange.graphics.lineStyle(1,0x000000);
					compOrange.graphics.beginFill(0xFF6200);
					compOrange.graphics.drawCircle(i*30+195,(10*30+35),10);
					addChild(compOrange);
				}
				else if (mindArray[10][i]==3){
					var compYellow:Sprite=new Sprite();
					compYellow.graphics.lineStyle(1,0x000000);
					compYellow.graphics.beginFill(0xFFF700);
					compYellow.graphics.drawCircle(i*30+195,(10*30+35),10);
					addChild(compYellow);
				}
				else if (mindArray[10][i]==4){
					var compGreen:Sprite=new Sprite();
					compGreen.graphics.lineStyle(1,0x000000);
					compGreen.graphics.beginFill(0x0ACF00);
					compGreen.graphics.drawCircle(i*30+195,(10*30+35),10);
					addChild(compGreen);
				}
				else if (mindArray[10][i]==5){
					var compPurple:Sprite=new Sprite();
					compPurple.graphics.lineStyle(1,0x000000);
					compPurple.graphics.beginFill(0x9000FF);
					compPurple.graphics.drawCircle(i*30+195,(10*30+35),10);
					addChild(compPurple);
				}
			}
		}
		private function hideAnswer():void{
			cover.graphics.lineStyle(1,0x000000);
			cover.graphics.beginFill(0x005499);
			cover.graphics.drawRect(180,290+30,120,30);
			cover.graphics.endFill();
			addChild(cover);
			var colAdder:uint=0;
			var rowAdder:uint=0;
			for (var i:uint=0; i<4; i++){
				if (correctCounter==1){
					colAdder=12;
				}
				else if (correctCounter==2){
					colAdder=0;
					rowAdder=12;
				}
				else if (correctCounter==3){
					colAdder=12;
					rowAdder=12;
				}
				var correctChoice:Sprite=new Sprite();
				correctChoice.graphics.lineStyle(1,0x000000);
				correctChoice.graphics.beginFill(0xFF0000);
				correctChoice.graphics.drawCircle(4*30+189+colAdder,10*30+29+rowAdder,4);
				addChild(correctChoice);
				correctCounter++;
			}
			correctCounter=0;
		}
		private function drawColors():void{
			var red:Sprite=new Sprite();
			addChild(red);
			red.graphics.lineStyle(1,0x000000);
			red.graphics.beginFill(0xFF0000);
			red.graphics.drawCircle(150,35,10);
			red.buttonMode=true;
			red.addEventListener(MouseEvent.CLICK,onRedClicked);
			var orange:Sprite=new Sprite();
			addChild(orange);
			orange.graphics.lineStyle(1,0x000000);
			orange.graphics.beginFill(0xFF6200);
			orange.graphics.drawCircle(150,65,10);
			orange.buttonMode=true;
			orange.addEventListener(MouseEvent.CLICK,onOrangeClicked);
			var yellow:Sprite=new Sprite();
			addChild(yellow);
			yellow.graphics.lineStyle(1,0x000000);
			yellow.graphics.beginFill(0xFFF700);
			yellow.graphics.drawCircle(150,95,10);
			yellow.buttonMode=true;
			yellow.addEventListener(MouseEvent.CLICK,onYellowClicked);
			var green:Sprite=new Sprite();
			addChild(green);
			green.graphics.lineStyle(1,0x000000);
			green.graphics.beginFill(0x0ACF00);
			green.graphics.drawCircle(150,125,10);
			green.buttonMode=true;
			green.addEventListener(MouseEvent.CLICK,onGreenClicked);
			var purple:Sprite=new Sprite();
			addChild(purple);
			purple.graphics.lineStyle(1,0x000000);
			purple.graphics.beginFill(0x9000FF);
			purple.graphics.drawCircle(150,155,10);
			purple.buttonMode=true;
			purple.addEventListener(MouseEvent.CLICK,onPurpleClicked);
		}
		private function onRedClicked(e:MouseEvent):void{
			movingRed.graphics.lineStyle(1,0x000000);
			movingRed.graphics.beginFill(0xFF0000);
			movingRed.graphics.drawCircle(0,0,10);
			movingRed.addEventListener(MouseEvent.CLICK, placeRed);
			addChild(movingRed);
			playerMoving=true;
			chosenColor=1;
		}
		private function onOrangeClicked(e:MouseEvent):void{
			movingOrange.graphics.lineStyle(1,0x000000);
			movingOrange.graphics.beginFill(0xFF6200);
			movingOrange.graphics.drawCircle(0,0,10);
			movingOrange.addEventListener(MouseEvent.CLICK, placeOrange);
			addChild(movingOrange);
			playerMoving=true;
			chosenColor=2;
		}
		private function onYellowClicked(e:MouseEvent):void{
			movingYellow.graphics.lineStyle(1,0x000000);
			movingYellow.graphics.beginFill(0xFFF700);
			movingYellow.graphics.drawCircle(0,0,10);
			movingYellow.addEventListener(MouseEvent.CLICK, placeYellow);
			addChild(movingYellow);
			playerMoving=true;
			chosenColor=3;
		}
		private function onGreenClicked(e:MouseEvent):void{
			movingGreen.graphics.lineStyle(1,0x000000);
			movingGreen.graphics.beginFill(0x0ACF00);
			movingGreen.graphics.drawCircle(0,0,10);
			movingGreen.addEventListener(MouseEvent.CLICK, placeGreen);
			addChild(movingGreen);
			playerMoving=true;
			chosenColor=4;
		}
		private function onPurpleClicked(e:MouseEvent):void{
			movingPurple.graphics.lineStyle(1,0x000000);
			movingPurple.graphics.beginFill(0x9000FF);
			movingPurple.graphics.drawCircle(0,0,10);
			movingPurple.addEventListener(MouseEvent.CLICK, placePurple);
			addChild(movingPurple);
			playerMoving=true;
			chosenColor=5;
		}
		private function placeRed(e:MouseEvent):void{
			var redRow:int=Math.floor((mouseY-20)/30);
			var redCol:int=Math.floor((mouseX-180)/30);
			if (redRow==10-guessesLeft&&redCol>=0&&redCol<=3){
				var placedRed:Sprite=new Sprite();
				placedRed.graphics.lineStyle(1,0x000000);
				placedRed.graphics.beginFill(0xFF0000);
				placedRed.graphics.drawCircle(redCol*30+195,(redRow*30+35),10);
				addChild(placedRed);
				mindArray[10-guessesLeft][Math.floor((mouseX-180)/30)]=1;
				playerMoving=false;
				movingRed.removeEventListener(MouseEvent.CLICK, placeRed);
				selector.visible=false;
				removeChild(movingRed);
			}
		}
		private function placeOrange(e:MouseEvent):void{
			var orangeRow:int=Math.floor((mouseY-20)/30);
			var orangeCol:int=Math.floor((mouseX-180)/30);
			if (orangeRow==10-guessesLeft&&orangeCol>=0&&orangeCol<=3){
				var placedOrange:Sprite=new Sprite();
				placedOrange.graphics.lineStyle(1,0x000000);
				placedOrange.graphics.beginFill(0xFF6200);
				placedOrange.graphics.drawCircle(orangeCol*30+195,(orangeRow*30+35),10);
				addChild(placedOrange);
				mindArray[10-guessesLeft][Math.floor((mouseX-180)/30)]=2;
				playerMoving=false;
				movingOrange.removeEventListener(MouseEvent.CLICK, placeOrange);
				selector.visible=false;
				removeChild(movingOrange);
			}
		}
		private function placeYellow(e:MouseEvent):void{
			var yellowRow:int=Math.floor((mouseY-20)/30);
			var yellowCol:int=Math.floor((mouseX-180)/30);
			if (yellowRow==10-guessesLeft&&yellowCol>=0&&yellowCol<=3){
				var placedYellow:Sprite=new Sprite();
				placedYellow.graphics.lineStyle(1,0x000000);
				placedYellow.graphics.beginFill(0xFFF700);
				placedYellow.graphics.drawCircle(yellowCol*30+195,(yellowRow*30+35),10);
				addChild(placedYellow);
				mindArray[10-guessesLeft][Math.floor((mouseX-180)/30)]=3;
				playerMoving=false;
				movingYellow.removeEventListener(MouseEvent.CLICK, placeYellow);
				selector.visible=false;
				removeChild(movingYellow);
			}
		}
		private function placeGreen(e:MouseEvent):void{
			var greenRow:int=Math.floor((mouseY-20)/30);
			var greenCol:int=Math.floor((mouseX-180)/30);
			if (greenRow==10-guessesLeft&&greenCol>=0&&greenCol<=3){
				var placedGreen:Sprite=new Sprite();
				placedGreen.graphics.lineStyle(1,0x000000);
				placedGreen.graphics.beginFill(0x0ACF00);
				placedGreen.graphics.drawCircle(greenCol*30+195,(greenRow*30+35),10);
				addChild(placedGreen);
				mindArray[10-guessesLeft][Math.floor((mouseX-180)/30)]=4;
				playerMoving=false;
				movingGreen.removeEventListener(MouseEvent.CLICK, placeGreen);
				selector.visible=false;
				removeChild(movingGreen);
			}
		}
		private function placePurple(e:MouseEvent):void{
			var purpleRow:int=Math.floor((mouseY-20)/30);
			var purpleCol:int=Math.floor((mouseX-180)/30);
			if (purpleRow==10-guessesLeft&&purpleCol>=0&&purpleCol<=3){
				var placedPurple:Sprite=new Sprite();
				placedPurple.graphics.lineStyle(1,0x000000);
				placedPurple.graphics.beginFill(0x9000FF);
				placedPurple.graphics.drawCircle(purpleCol*30+195,(purpleRow*30+35),10);
				addChild(placedPurple);
				mindArray[10-guessesLeft][Math.floor((mouseX-180)/30)]=5;
				playerMoving=false;
				movingPurple.removeEventListener(MouseEvent.CLICK, placePurple);
				selector.visible=false;
				removeChild(movingPurple);
			}
		}
		private function dropColors():void{
			addChild(colorHolder);
			colorsTimer.start();
			colorsTimer.addEventListener(TimerEvent.TIMER, newColor)
		}
		private function newColor(e:TimerEvent):void{
			var color:Sprite=new Sprite();
			color.graphics.lineStyle(1,0x000000);
			chosenColor2=Math.floor(Math.random()*5)+1;
			if (chosenColor2==1){
				color.graphics.beginFill(0xFF0000);
			}
			else if (chosenColor2==2){
				color.graphics.beginFill(0xFF6200);
			}
			else if (chosenColor2==3){
				color.graphics.beginFill(0xFFF700);
			}
			else if (chosenColor2==4){
				color.graphics.beginFill(0x0ACF00);
			}
			else if (chosenColor2==5){
				color.graphics.beginFill(0x9000FF);
			}
			color.graphics.drawCircle(0,0,10);
			color.buttonMode=true;
			colorHolder.addChild(color);
			color.y=-10;
			chosenColor2=Math.floor(Math.random()*2)+1;
			if (chosenColor2==1){
				color.x=Math.random()*250-130;
			}
			else if (chosenColor2==2){
				color.x=Math.random()*250+350;
			}
			color.addEventListener(MouseEvent.CLICK, colorClicked);
		}
		private function colorClicked(e:MouseEvent):void{
			e.currentTarget.removeEventListener(MouseEvent.CLICK, colorClicked);
			var colorToRemove:Sprite=e.currentTarget as Sprite;
			colorHolder.removeChild(colorToRemove);
		}
		private function onEnterFrame(e:Event):void{
			for (i=0; i<colorHolder.numChildren; i++){
				var droppedColor:Sprite=colorHolder.getChildAt(i) as Sprite;
				droppedColor.y+=5;
				if (droppedColor.y>400){
					droppedColor.removeEventListener(MouseEvent.CLICK,colorClicked)
					colorHolder.removeChild(droppedColor);
				}
			}
			if (playerMoving){
				if (chosenColor==1){
					movingRed.x=mouseX;
					movingRed.y=mouseY;
				}
				else if (chosenColor==2){
					movingOrange.x=mouseX;
					movingOrange.y=mouseY;
				}
				else if (chosenColor==3){
					movingYellow.x=mouseX;
					movingYellow.y=mouseY;
				}
				else if (chosenColor==4){
					movingGreen.x=mouseX;
					movingGreen.y=mouseY;
				}
				else if (chosenColor==5){
					movingPurple.x=mouseX;
					movingPurple.y=mouseY;
				}
				var row:int=Math.floor((mouseY-20)/30);
				var col:int=Math.floor((mouseX-180)/30);
				selector.visible=false;
				if (row==10-guessesLeft&&col>=0&&col<=3){
					selector.visible=true;
					selector.x=180+col*30;
					selector.y=20+row*30;
				}
				else{
					selector.visible=false;
				}
			}
			fullBox=true;
			for (var i:uint=0; i<4; i++){
				if (mindArray[10-guessesLeft][i]==0){
					fullBox=false;
				}
			}
			if (fullBox){
				checkChoice();
			}
		}
		private function checkChoice():void{
			var colAdder:uint=0;
			var rowAdder:uint=0;
			var tempArray:Array=new Array(4);
			for (var j:uint=0; j<4; j++){
				tempArray[j]=mindArray[10][j];
			}
			for (var i:uint=0; i<4; i++){
				if (correctCounter==1){
					colAdder=12;
				}
				else if (correctCounter==2){
					colAdder=0;
					rowAdder=12;
				}
				else if (correctCounter==3){
					colAdder=12;
					rowAdder=12;
				}
				//trace ("check1",mindArray[10-guessesLeft][i], mindArray[10][i]);
				if (mindArray[10-guessesLeft][i]==mindArray[10][i]){
					//trace ("check2",mindArray[10-guessesLeft][i], mindArray[10][i]);
					var correctChoice:Sprite=new Sprite();
					correctChoice.graphics.lineStyle(1,0x000000);
					correctChoice.graphics.beginFill(0xFF0000);
					correctChoice.graphics.drawCircle(4*30+189+colAdder,(10-guessesLeft)*30+29+rowAdder,4);
					addChild(correctChoice);
					correctCounter++;
					mindArray[10][i]=0;
					mindArray[10-guessesLeft][i]=0;
					if (correctCounter==4){
						revealAnswer();
					}
				}
			}
			for (var h:uint=0; h<4; h++){
				for (var k:uint=0; k<4; k++){
					if (correctCounter==1){
						colAdder=12;
					}
					else if (correctCounter==2){
						colAdder=0;
						rowAdder=12;
					}
					else if (correctCounter==3){
						colAdder=12;
						rowAdder=12;
					}
					//trace ("check3",mindArray[10-guessesLeft][i], mindArray[10][h]);
					if ((mindArray[10-guessesLeft][k]==mindArray[10][h])&&(h!=k)&&(mindArray[10-guessesLeft][k]!=0)&&(mindArray[10][h]!=0)){
						//trace ("check4",mindArray[10-guessesLeft][i], mindArray[10][h]);
						var correctChoice2:Sprite=new Sprite();
						correctChoice2.graphics.lineStyle(1,0x000000);
						correctChoice2.graphics.beginFill(0xFFFFFF);
						correctChoice2.graphics.drawCircle(4*30+189+colAdder,(10-guessesLeft)*30+29+rowAdder,4);
						addChild(correctChoice2);
						correctCounter++;
						mindArray[10][h]=0;
						mindArray[10-guessesLeft][k]=0;
					}
				}
			}
			guessesLeft--;
			if (guessesLeft==0){
				revealAnswer();
			}
			correctCounter=0;
			for (var g:uint=0; g<4; g++){
				mindArray[10][g]=tempArray[g];
			}
			return;
		}
		private function revealAnswer():void{
			removeChild(cover);
			if (guessesLeft!=0){
				var winner:TextField=new TextField;
				winner.text="You broke the code. Congratulations!"
				winner.textColor=0x008CFF;
				winner.height=20;
				winner.width=200
				winner.x=345;
				winner.y=110;
				addChild(winner);
			}
			else{
				var loser:TextField=new TextField;
				loser.text="You couldn't break the code. Try again next time."
				loser.textColor=0x008CFF;
				loser.height=20;
				loser.width=400
				loser.x=345;
				loser.y=110;
				addChild(loser);
				return;
			}
			guessesLeft=0;
		}
	}
}