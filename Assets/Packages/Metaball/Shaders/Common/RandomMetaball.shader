Shader "Custom/RandomMetaball" {
	Properties{
		_MainTex("Texture", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,1)
		_Scale("Scale", Range(0.01, 0.5)) = 0.24
	}
	SubShader{
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha

		Pass{
			CGPROGRAM
			#pragma target 5.0
			#pragma vertex vert
			#pragma geometry geom
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct ParticleData {
				bool isActive;
				int id;
				float life;
				float2 position;
				float2 velocity;
			};

			struct v2g {
				float4 pos : POSITION;
				float2 rand : TEXCOORD0;
				float scale : TEXCOORD1;
			};

			struct g2f {
				float4 pos : SV_POSITION;
				float2 rand : TEXCOORD0;
				float2 uv : TEXCOORD1;
			};

			StructuredBuffer<ParticleData> _ParticlesBuffer;
			sampler2D _MainTex;
			float _Scale;
			float4 _Color;

			float rand(float2 co) {
				return frac(sin(dot(co.xy, float2(12.9898, 78.233))) * 43758.5453);
			}

			v2g vert(uint id: SV_VertexID) {
				v2g o;
				o.pos = float4(_ParticlesBuffer[id].position.xy, 0, 1);

				if (_ParticlesBuffer[id].isActive) {
					o.scale = _Scale * min(1, _ParticlesBuffer[id].life);
				} else {
					o.scale = 0;
					o.pos = float4(0xffffff, 0xffffff, 0, 1);
				}
				
				o.rand = float2(rand(id), rand(id+1));

				return o;
			}

			[maxvertexcount(4)]
			void geom(point v2g input[1], inout TriangleStream<g2f> outStream) {
				g2f o;

				float4 pos = input[0].pos;

				float4x4 billboardMatrix = UNITY_MATRIX_V;
				billboardMatrix._m03 = billboardMatrix._m13 = billboardMatrix._m23 = billboardMatrix._m33 = 0;

				for (int x = 0; x < 2; x++) {
					for (int y = 0; y < 2; y++) {
						float2 uv = float2(x, y);
						o.uv = uv;

						o.pos = pos + mul(float4((uv * 2 - float2(1, 1)) * input[0].scale, 0, 1), billboardMatrix);
						o.pos = mul(UNITY_MATRIX_VP, o.pos);

						o.rand = input[0].rand;

						outStream.Append(o);
					}
				}

				outStream.RestartStrip();
			}

			fixed4 frag(g2f i) : SV_Target{
				float2 luminance = tex2D(_MainTex, i.uv).ra;
				fixed4 col = fixed4(luminance.x, i.rand.x, i.rand.y, luminance.y);
				return col;
			}
				
			ENDCG
		}
	}
}
