using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameController : MonoBehaviour
{
    public static bool gamePaused = false;
    
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public static void PauseGame(){
        Time.timeScale = 0f;
        gamePaused = true;
    }

    public static void UnPauseGame(){
        Time.timeScale = 1f;
        gamePaused = false;
    }
}
