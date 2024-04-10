using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class FinishPlatform : MonoBehaviour
{
    public GameObject winText;
    float startingY;
    bool finish = false;

    // Start is called before the first frame update
    void Start()
    {
        startingY = gameObject.transform.position.y;
    }

    // Update is called once per frame
    void Update()
    {
        if  (gameObject.transform.position.y >= (startingY + 5)){
            SceneManager.LoadScene("MyLevel");
        }
        if (finish){
            gameObject.transform.Translate(Vector3.up * Time.deltaTime);
        }
    }

    private void OnTriggerEnter(Collider other) {
        finish = true;
        winText.SetActive(true);
    }
}
