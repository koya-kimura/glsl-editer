// 参考文献 : https://speakerdeck.com/hanachiru/1shi-jian-dehuragumentosiedaru-men-karaborofalseitu-made?slide=44

void mainImage(out vec4 fragColor,in vec2 fragCoord)
{
    vec2 uv=fragCoord/iResolution.xy;

    float m_dis = 1.0;
    vec2 m_point;

    for(float i = 0.; i < 100.; i ++){
        vec2 point = vec2(abs(sin(iTime*i/500.)+sin(iTime*i/700.)), abs(sin(iTime*i/400.)+sin(iTime*i/300.)));
        float dis = distance(uv, point);

        if(dis < m_dis){
            m_dis = min(dis, m_dis);
            m_point = point;
        }
    }

    fragColor = vec4(m_point, 0., 1.);
}