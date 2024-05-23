using System;
using System.Collections;
using System.Collections.Generic;
using System.Security.Cryptography.X509Certificates;
using UnityEngine;

public class LockMiniGame : MonoBehaviour
{
    public bool gamePaused = false;
    public bool safe = false;
    public int angle = -90;
    private int[] passcode = new int[3];
    private int codeEntered = 0;
    private int digit;
    private int lockStep = 0;


    public Transform lockSlot;
    public Transform lockPick;
    public GameObject doorLock;

    // Start is called before the first frame update
    void Start()
    {
        if (safe){
            digit = 9;
        } else{
            digit = 4;
        }
        for (int i = 0; i < passcode.Length; i++){
            passcode[i] = UnityEngine.Random.Range(1, digit);
        }
        Debug.Log(lockSlot.rotation);
    }

    // Update is called once per frame
    void Update()
    {
        if (gamePaused){
            if (!safe){
                if (Input.GetKeyDown(KeyCode.UpArrow) || Input.GetKeyDown(KeyCode.W)) {
                    if (codeEntered < 3){
                        codeEntered++;
                        lockPick.position = lockPick.position + new Vector3(0, 0, 0.35f);
                    }   
                } else if (Input.GetKeyDown(KeyCode.DownArrow) || Input.GetKeyDown(KeyCode.S)) {
                    if (codeEntered > 0){
                        codeEntered--;
                        lockPick.position = lockPick.position - new Vector3(0, 0, 0.35f);
                    }
                } else if (Input.GetKeyDown(KeyCode.RightArrow) || Input.GetKeyDown(KeyCode.D)){
                    if (codeEntered == passcode[lockStep]){
                        if (lockStep < 2) { lockStep++; }
                        Vector3 newRotation = new Vector3(angle, 90, -90);
                        angle += 60;
                        lockSlot.localEulerAngles = newRotation;
                    }
                }
            }
        }
    }
}
