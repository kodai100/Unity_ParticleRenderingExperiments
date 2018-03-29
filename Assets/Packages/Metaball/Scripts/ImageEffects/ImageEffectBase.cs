using UnityEngine;

public abstract class ImageEffectBase : MonoBehaviour
{
    [SerializeField] Shader _shader;
    
    protected Material _material;

    protected virtual void Start()
    {
        _material = new Material(_shader);
    }

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        UpdateShaderParams(_material);

        Graphics.Blit(source, destination, _material);
    }

    protected abstract void UpdateShaderParams(Material material);
}