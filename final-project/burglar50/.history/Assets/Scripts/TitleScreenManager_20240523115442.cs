using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class TitleScreenManager : MonoBehaviour
{
    public GameObject blinkingText;
    public bool blinking = true;
    
    // Start is called before the first frame update
    void Start()
    {
        blinkingText.SetActive(true);
        StartCoroutine("BlinkText");
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKey(KeyCode.Escape)) {
            Application.Quit();
        }

        if (Input.GetKey(KeyCode.UpArrow) || Input.GetKey(KeyCode.W)) {
            SceneManager.LoadScene("Play");
        }
    }

    public IEnumerator BlinkText() {
        while (blinking) {
            blinkingText.SetActive(false);
            yield return new WaitForSeconds(0.7f);
            blinkingText.SetActive(true);
            yield return new WaitForSeconds(1f);
        }
    }
}
