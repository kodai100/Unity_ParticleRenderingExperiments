Shader "Custom/Upsample" {
	Properties{
		_MainTex("Texture", 2D) = "white" {}
	}
	SubShader{
		Pass{

			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag

			#include "UnityCG.cginc"

			sampler2D _MainTex;

			fixed4 frag(v2f_img i) : COLOR{
				fixed4 color = tex2D(_MainTex, i.uv);
				return color;
			}

			ENDCG
		}
	}
}