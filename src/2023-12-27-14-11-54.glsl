// https://qiita.com/7CIT/items/4126d23ffb1b28b80f27
// https://qiita.com/7CIT/items/589cba0a739b9d8803cf
// https://qiita.com/7CIT/items/fe33b9b341b9918b6c3d

#define PI 3.1415926535
#define TAU 6.2831853

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

float lengthN(vec2 v,float n){
    vec2 tmp=pow(abs(v),vec2(n));
    return pow(tmp.x+tmp.y,1./n);
}

float lPoly(vec2 p,float n){
    float a=atan(p.x,p.y)+PI;
    float r=TAU/n;
    return cos(floor(.5+a/r)*r-a)*length(p)/cos(r*.5);
}

float lStar(vec2 p,float n){
    return min(lPoly(p,n*.5),lPoly(mod(n,2.)!=0.?vec2(-p.x,p.y):p*rot(TAU/n),n*.5));
}

float sumabs(vec2 p){return abs(p.x)+abs(p.y);}

float maxabs(vec2 p){return max(abs(p.x),abs(p.y));}

float lpnorm(vec2 p,float n){vec2 t=pow(abs(p),vec2(n));return pow(t.x+t.y,1./n);}

vec2 mPolar(vec2 xy){
    float a=atan(xy.y,xy.x);
    float r=0.;
    r=lPoly(xy,6.);
    return vec2(a/PI,r);
}

void mainImage(out vec4 fragColor,in vec2 fragCoord)
{
    vec2 uv=fragCoord/iResolution.xy;
    uv-=.5;
    uv=mPolar(uv);
    
    vec3 col=vec3(step(uv.y+random(vec2(uv.y))*.05,.4));
    
    fragColor=vec4(col,1.);
}