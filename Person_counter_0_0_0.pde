
//import processing.serial.*;
import KinectPV2.*;
//Serial myPort;
KinectPV2 kinect;
int last =0;
int current=0;
int del=500;
int count=0;
int oldState=0;
int state=0;
void setup() {   
  size(512, 384);   
  kinect = new KinectPV2(this);   
  kinect.enableDepthMaskImg(true);
  kinect.enableSkeletonDepthMap(true);
  kinect.init();

//  myPort= new Serial(this, Serial.list()[1],115200);
}  
void draw() {   
  background(0);   
  image(kinect.getDepthMaskImage(), 0, 0);
  strokeWeight(10); 
  stroke(256,0,0);
  line(256, 0, 256, 384);
  //line(170, 0, 170, 384);
  //line(0, 240, 512, 240);
  //line(0, 100, 512, 100);
  //get the skeletons as an Arraylist of KSkeletons
  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonDepthMap();
  //get the skeleton as an Arraylist mapped to the color frame
  //ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();
  //individual joints
  //for (int i = 0; i < skeletonArray.size(); i++) {
      if (skeletonArray.size()>0){
      KSkeleton skeleton = (KSkeleton) skeletonArray.get(0);
      KJoint[] joints = skeleton.getJoints();
      //color col  = skeleton.getIndexColor();
       boolean light=true;
       float x=joints[3].getX();
       
      // float y=joints[7].getY();
       //int [] rawData = kinect.getRawDepthData();
      // int itemDepth = rawData[int(y)*512+int(x)];
    //   int hand=skeleton.getLeftHandState();
      // System.out.println( itemDepth ) ;
       //System.out.printf(" %.2f\n\r", x);
      
      if (x >=0 && x<= 256){
        state=1;
      }
      if (x >=257){
        state=2;
      }
      }

      
      if (skeletonArray.size() ==0){
        state=0;
        
        
      
      }
      
      switch(state){
      case 1:
        if (oldState==2 && count > 0){
         count--; 
        }
        break;
        case 2:
        if (oldState==1){
         count++; 
        }
        break;
      }
      oldState=state;
      //current=round(.02*x);
      //System.out.println(skeletonArray.size());
      
          
          
      
      fill(255,0,0);
      stroke(255,0,0);
  //   drawBody(joints);
   //   drawHandState(joints[KinectPV2.JointType_HandRight]);
  //    drawHandState(joints[KinectPV2.JointType_HandLeft]);
      
    System.out.println(count);
    //System.out.println(oldState);
//    myPort.write(skeletonArray.size());
  }


/**
SpineMid  = 1; 
Neck   = 2; 
Head   = 3; 
ShoulderLeft  = 4; 
ElbowLeft  = 5; 
WristLeft     = 6; 
HandLeft  = 7; 
ShoulderRight = 8; 
ElbowRight = 9; 
WristRight = 10; 
HandRight  = 11; 
HipLeft  = 12; 
KneeLeft  = 13; 
AnkleLeft  = 14; 
FootLeft  = 15; 
HipRight  = 16; 
KneeRight  = 17; 
AnkleRight = 18; 
FootRight  = 19; 
SpineShoulder = 20; 
HandTipLeft = 21; 
ThumbLeft  = 22; 
HandTipRight = 23; 
ThumbRight = 24;
**/