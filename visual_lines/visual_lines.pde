size(400,400);
translate(width/2,height/2);
rotate(HALF_PI);
for(int i = 0 ; i < 300;i++)
 { line(0,0,i*cos(121*i),i*sin(121*i));
rotate(radians(121))  ;
stroke(i%255);
}
