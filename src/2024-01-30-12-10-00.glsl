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

// -------------------------

#iChannel0"https://66.media.tumblr.com/tumblr_mcmeonhR1e1ridypxo1_500.jpg"
#iChannel1"https://1.bp.blogspot.com/-7OzCCLysaWY/VCOJTY7fF5I/AAAAAAAAmvY/HqoY2F8aEqA/s800/eto_mark05_tatsu.png"

vec3 colors[5]=vec3[](
    vec3(1.,0.,0.),// 赤
    vec3(0.,1.,0.),// 緑
    vec3(0.,0.,1.),// 青
    vec3(1.,1.,0.),// 黄色
    vec3(1.,0.,1.)// マゼンタ
);

void mainImage(out vec4 fragColor,in vec2 fragCoord)
{
    vec2 uv=fragCoord/iResolution.xy;

    vec4 col = texture2D(iChannel0, uv);

    float gray=(col.r+col.g+col.b)/3.;
    int ch=int(floor(gray*5.));

    col.rgb = colors[ch];

    fragColor=col;
}