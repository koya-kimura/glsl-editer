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

#iChannel0 "../assets/image/night-shibuya.png"

void mainImage(out vec4 fragColor,in vec2 fragCoord)
{
    vec2 uv = fragCoord/iResolution.xy;

    float grid = 200.;

    uv.y=floor(uv.y*grid)/grid;

    // vec2 coord = floor(uv*grid)/grid;
    // vec2 normCoord = fract(uv*grid);
    // vec2 normCoordPol = xy2pol((normCoord-.5)*2.);
    // float r = random(coord);
    // if(r < .25){
    //     uv.y=floor(uv.y*grid)/grid;
    // } else if(r < .5) {
    //     uv.x=floor(uv.x*grid)/grid;
    // }

    vec4 col = texture2D(iChannel0, uv);

    fragColor = col;
}