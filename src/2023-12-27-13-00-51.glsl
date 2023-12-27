float random(vec2 st){
    return fract(sin(dot(st.xy,vec2(12.9898,78.233)))*43758.5453123);
}

float sumabs(vec2 p){return abs(p.x)+abs(p.y);}

void mainImage(out vec4 fragColor,in vec2 fragCoord)
{
    vec2 uv=fragCoord/iResolution.xy;

    float d=1.;
    float c=1.;
    vec2 m_point;

    for(float i=0.;i<100.;i++){
        vec2 point=vec2(random(vec2(i)), random(vec2(i+0.1)));
        vec2 r = uv - point;
        float dis=length(r);

        if(dis<d){
            d=min(dis,d);
        }
    }

    fragColor=vec4(vec3(d),1.);
}