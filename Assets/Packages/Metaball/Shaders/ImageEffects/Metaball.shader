Shader "ImageEffect/Metaball" {
	Properties{
		_MainTex("Texture", 2D) = "white" {}
		_Threshold("Threshold", Float) = 0.0
		_Color("Color", Color) = (1, 1, 1, 1)
	}
	SubShader{
		Pass{

			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "../Common/ClassicNoise3D.cginc"
			#include "../Common/PhotoshopMath.cginc"

			sampler2D _MainTex;
			float _Threshold;
			float _EdgeThreshold;
			fixed4 _Color;
			fixed4 _EdgeColor;
			fixed4 _FlowColor;

			sampler2D _OrnamentTexture;

			fixed4 frag(v2f_img i) : COLOR{

				float luminance = tex2D(_MainTex, i.uv).a;
				float2 detect = tex2D(_MainTex, i.uv).gb;

				fixed4 color;
				if (luminance > _Threshold) {
					color = _Color;
				} else if (luminance > _EdgeThreshold){
					color = _EdgeColor;
				} else {
					color = (fixed4)0;
				}

				
				if (detect.x > 0.8) {
					// cnoise(float3(i.uv * 20, _Time.y)) * 2 - 1) * 0.01
					float defaultHue = RGBToHSL(_FlowColor.rgb).r;
					float offset = (cnoise(float3(i.uv * 5, _Time.y)) * 2 - 1) * 0.1;

					color = float4(HSLToRGB(float3(defaultHue, 0.8 + offset, 1)), 1);
				}

				return color;
			}

			ENDCG
		}
	}
}