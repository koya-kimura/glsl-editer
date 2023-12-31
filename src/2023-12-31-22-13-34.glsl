#define PI 3.1415926535

float random(vec2 st){
    return fract(sin(dot(st.xy,vec2(12.9898,78.233)))*43758.5453123);
}

mat2 rot(float angle){
    return mat2(cos(angle),-sin(angle),sin(angle),cos(angle));
}

float atan2(float y,float x){
    return x==0.?sign(y)*PI/2.:atan(y,x);
}

vec2 xy2pol(vec2 xy){
    return vec2(atan2(xy.y,xy.x),length(xy));
}

vec2 pol2xy(vec2 pol){
    return pol.y*vec2(cos(pol.x),sin(pol.x));
}

float easeInSine(float x){
    return 1.-cos((x*3.14159265359)/2.);
}

float easeOutSine(float x){
    return sin((x*3.14159265359)/2.);
}

float easeInOutSine(float x){
    return-(cos(3.14159265359*x)-1.)/2.;
}

float easeInQuad(float x){
    return x*x;
}

float easeOutQuad(float x){
    return 1.-(1.-x)*(1.-x);
}

float easeInOutQuad(float x){
    return x<.5?2.*x*x:1.-pow(-2.*x+2.,2.)/2.;
}

float easeInCubic(float x){
    return x*x*x;
}

float easeOutCubic(float x){
    return 1.-pow(1.-x,3.);
}

float easeInOutCubic(float x){
    return x<.5?4.*x*x*x:1.-pow(-2.*x+2.,3.)/2.;
}

float easeInQuart(float x){
    return x*x*x*x;
}

float easeOutQuart(float x){
    return 1.-pow(1.-x,4.);
}

float easeInOutQuart(float x){
    return x<.5?8.*x*x*x*x:1.-pow(-2.*x+2.,4.)/2.;
}

float easeInQuint(float x){
    return x*x*x*x*x;
}

float easeOutQuint(float x){
    return 1.-pow(1.-x,5.);
}

float easeInOutQuint(float x){
    return x<.5?16.*x*x*x*x*x:1.-pow(-2.*x+2.,5.)/2.;
}

float easeInExpo(float x){
    return x==0.?0.:pow(2.,10.*x-10.);
}

float easeOutExpo(float x){
    return x==1.?1.:1.-pow(2.,-10.*x);
}

float easeInOutExpo(float x){
    return x==0.?0.:x==1.?1.:x<.5?pow(2.,20.*x-10.)/2.:(2.-pow(2.,-20.*x+10.))/2.;
}

float easeInCirc(float x){
    return 1.-sqrt(1.-x*x);
}

float easeOutCirc(float x){
    return sqrt(1.-pow(x-1.,2.));
}

float easeInOutCirc(float x){
    return x<.5?(1.-sqrt(1.-pow(2.*x,2.)))/2.:(sqrt(1.-pow(-2.*x+2.,2.))+1.)/2.;
}

float easeOutBack(float x){
    float c1=1.70158;
    float c3=c1+1.;
    return 1.+c3*pow(x-1.,3.)+c1*pow(x-1.,2.);
}

float easeInOutBack(float x){
    float c1=1.70158;
    float c2=c1*1.525;
    return x<.5?(pow(2.*x,2.)*((c2+1.)*2.*x-c2))/2.:(pow(2.*x-2.,2.)*((c2+1.)*(x*2.-2.)+c2)+2.)/2.;
}

// イージング関数を配列にまとめる
float easeFunctions(float x,int i){
    float functions[24];
    functions[0]=easeInCirc(x);
    functions[1]=easeInCubic(x);
    functions[2]=easeInExpo(x);
    functions[3]=easeInOutBack(x);
    functions[4]=easeInOutBack(x);
    functions[5]=easeInOutCirc(x);
    functions[6]=easeInOutCubic(x);
    functions[7]=easeInOutExpo(x);
    functions[8]=easeInOutQuad(x);
    functions[9]=easeInOutQuart(x);
    functions[10]=easeInOutQuint(x);
    functions[11]=easeInOutSine(x);
    functions[12]=easeInQuad(x);
    functions[13]=easeInQuart(x);
    functions[14]=easeInQuint(x);
    functions[15]=easeInSine(x);
    functions[16]=easeOutBack(x);
    functions[17]=easeOutCirc(x);
    functions[18]=easeOutCubic(x);
    functions[19]=easeOutExpo(x);
    functions[20]=easeOutQuad(x);
    functions[21]=easeOutQuart(x);
    functions[22]=easeOutQuint(x);
    functions[23]=easeOutSine(x);

    return i>=0&&i<24?functions[i]:x;
}

void mainImage(out vec4 fragColor,in vec2 fragCoord){
    vec2 uv=fragCoord/iResolution.xy;
    vec3 col=vec3(0.);

    float n=23.;
    for(float i=0.;i<n;i++){
        float t=fract(iTime/4.);
        vec2 p=vec2(easeFunctions(t,int(i)),(i+.5)/n);

        float l=length(uv-p);

        if(l<.02){
            col=vec3(1.);
        }
    }

    fragColor=vec4(col,1.);
}
