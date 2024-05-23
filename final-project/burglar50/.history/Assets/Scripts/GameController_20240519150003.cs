using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class GameController : MonoBehaviour
{
    public static bool gamePaused = false;
    public PlayerController player;
    
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Escape)) {
            Application.Quit();
        }
    }

    public static void PauseGame(){
        Time.timeScale = 0f;
        gamePaused = true;
    }

    public static void UnPauseGame(){
        Time.timeScale = 1f;
        gamePaused = false;
    }

    private void OnTriggerEnter2D(Collider2D other){
        if (other.CompareTag("Player")){
            if (player != null && player.bag){
                SceneManager.LoadScene("Play");
            }
        }
    }
}
