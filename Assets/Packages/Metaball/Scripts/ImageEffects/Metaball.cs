using UnityEngine;

public class Metaball : ImageEffectBase {

    [SerializeField]
    Color _color = Color.blue;

    [SerializeField]
    Color _edgeColor = Color.blue;

    [SerializeField]
    float _threshold = 0.5f;

    [SerializeField]
    float _edgeThreshold = 0.5f;

    [SerializeField]
    Color _flowColor = Color.red;

    [SerializeField]
    Texture2D _ornamentTexture;

    protected override void UpdateShaderParams(Material material)
    {
        material.SetTexture("_OrnamentTexture", _ornamentTexture);
        material.SetColor("_Color", _color);
        material.SetColor("_EdgeColor", _edgeColor);
        material.SetColor("_FlowColor", _flowColor);
        material.SetFloat("_Threshold", _threshold);
        material.SetFloat("_EdgeThreshold", _edgeThreshold);
    }
}
