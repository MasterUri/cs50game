using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TitleScreenManager : MonoBehaviour
{
    public GameObject blinkingText;
    
    // Start is called before the first frame update
    void Start()
    {
        blinkingText.SetActive(true);
        StartCoroutine("BlinkText");
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public IEnumerator BlinkText() {
        blinkingText.SetActive(false);
        yield return new WaitForSeconds(1);
        blinkingText.SetActive(true);
        yield return new WaitForSeconds(1);
    }
}