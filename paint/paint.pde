import controlP5.*;
ControlP5 cp5;

boolean ft = true;
boolean e_active = false;
boolean fbkt_active = false;
int c = color(0,0,0);
int prevC;

PImage img_P_eraser, img_A_eraser;
PImage img_P_spen, img_A_spen;
PImage img_P_spike, img_A_spike;
PImage img_P_fbkt, img_A_fbkt;

Button er,spn,spk,fill_bucket;
Slider set_siz;

int brush = 1;
float pen_size = 10;

void setup()
{
  size(1000,700);
  color_background();

  
  img_P_eraser = loadImage("pe.png");
  img_A_eraser = loadImage("ae.png");
   
  img_P_spen = loadImage("psp.png");
  img_A_spen = loadImage("asp.png");
  
  img_P_spike = loadImage("pspk.png");
  img_A_spike = loadImage("aspk.png");
  
  img_P_fbkt = loadImage("pfbkt.png");
  img_A_fbkt = loadImage("afbkt.png");
  
  
  cp5 = new ControlP5(this);
  
  cp5.addColorWheel("c" , 5 , 5 , 200 )
     .setRGB(color(128,0,255))
     ;
  
  
     
    
  
  er = cp5.addButton("erase")
          .setValue(1)
          .setPosition(5,220)
          .setSize(34,34)
          .setImage(img_P_eraser)
          ;

  spn = cp5.addButton("simplepen")
           .setValue(2)
           .setPosition(59,220)
           .setSize(34,34)
           .setImage(img_A_spen)
           ;
           
  spk = cp5.addButton("spikepen")
           .setValue(3)
           .setPosition(113,220)
           .setSize(34,34)
           .setImage(img_P_spike)
           ;
  
  fill_bucket = cp5.addButton("fbckt")
          .setValue(1)
          .setPosition(5,320)
          .setSize(34,34)
          .setImage(img_P_fbkt)
          ;
  
  set_siz = cp5.addSlider("pensize")
               .setPosition(5,270)
               .setSize(200,20)
               .setRange(1,100)
               .setValue(10)
               .setCaptionLabel("pen size")
               .setColorCaptionLabel(color(255,0,0))
               ;
  set_siz.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

}

void color_background()
{
  background(c);
  fill(255);
  rect(0,0,210,height);
  fill(255,0,0);
  rect(210,0,4,height);
}

void erase_all()
{
  background(0);
  fill(255);
  rect(0,0,210,height);
}


void simplePen(float x, float y , float siz)
{
  circle(x,y,siz);
}

void spikes(float x, float y, float siz)
{
  rectMode(CENTER);
  
  rect(x,y,1,siz*2);
    
  translate(x,y);    
  rotate(PI/4);
  rect(0,0,1,siz*2);
  rotate(-PI/4);
  translate(-x,-y);

  translate(x,y);    
  rotate(-PI/4);
  rect(0,0,1,siz*2);
  rotate(PI/4);
  translate(-x,-y);    

  rect(x,y,siz*2,1);
  
  rectMode(0);
}

void draw()
{
  
  
  if(mousePressed && mouseButton == LEFT && mouseX > 220)
  {
    fill(c);
    noStroke();
    if(brush == 1)
      simplePen(mouseX,mouseY,pen_size);
    else if(brush == 2)
      spikes(mouseX,mouseY,pen_size);
    
    else if(brush == 3)
      color_background();
  }
  
  if(keyPressed && key == 'c')
  {
    erase_all();
  }
  
  
  if(e_active)
  {
    er.setImage(img_A_eraser);
  }
  else
  {
    er.setImage(img_P_eraser);
  }
  
  if(brush == 1)
  {
    spn.setImage(img_A_spen);
    spk.setImage(img_P_spike);
    fill_bucket.setImage(img_P_fbkt);
  }
  else if(brush == 2)
  {
    fill_bucket.setImage(img_P_fbkt);
    spn.setImage(img_P_spen);
    spk.setImage(img_A_spike);
  }
  else if(brush == 3)
  {
    spn.setImage(img_P_spen);
    spk.setImage(img_P_spike);
    fill_bucket.setImage(img_A_fbkt);
  }

}


public void erase(int theValue)
{
  if(!ft)
    e_active = !e_active;
   
   
   
  if(e_active)
  {
    prevC = c;
    c = 0;
  }
  else
  {
    c = prevC;
  }

}

public void simplepen(int theValue)
{
  if(!ft)
    brush = 1;

}

public void spikepen(int theValue)
{
  if(!ft)
    brush = 2;
}

public void fbckt(int theValue)
{
  if(!ft)
    brush = 3;

}

public void pensize(float psize)
{
  if(!ft)
    pen_size = psize;
  if(ft)c = color(128,0,255);
  ft = false;
  
}
