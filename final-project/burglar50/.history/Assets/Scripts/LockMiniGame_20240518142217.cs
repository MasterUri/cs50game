using System;
using System.Collections;
using System.Collections.Generic;
using System.Security.Cryptography.X509Certificates;
using UnityEngine;

public class LockMiniGame : MonoBehaviour
{
    public bool safe = false;
    public int angle = -90;

    private int[] passcode = new int[3];
    private int codeEntered = 0;
    private int digit;
    private int lockStep = 0;
    private bool[] safeMatch = new bool[3];


    public Transform lockSlot;
    public Transform lockPick = null;
    public Lock doorLock;
    public PlayerController player;

    // Start is called before the first frame update
    void Start()
    {
        if (safe){
            digit = 8;
            angle = 0;
        } else{
            digit = 4;
            angle = -90;
        }

        for (int i = 0; i < passcode.Length; i++){
            passcode[i] = UnityEngine.Random.Range(1, digit);
            Debug.Log(passcode[i]);
        }

       
    }

    // Update is called once per frame
    void Update()
    {
        if (GameController.gamePaused){
            if (doorLock.locked) {
                
                // door lock
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
                            if (lockStep < 3) { lockStep++; }
                            angle += 60;
                            lockSlot.localEulerAngles = new Vector3(angle, 90, -90);
                            if (lockStep == 3) { doorLock.locked = false; }
                        }
                    }
                
                // safe lock
                } else {
                    if (codeEntered == passcode[lockStep]){ safeMatch[lockStep] = true; }
                    else if (lockStep == 2 && safeMatch[lockStep] == true) {
                            doorLock.locked = false;
                        }
                    else {safeMatch[lockStep] = false; }

                    if (Input.GetKeyDown(KeyCode.RightArrow) || Input.GetKeyDown(KeyCode.D)) {
                        if (lockStep == 1 && safeMatch[lockStep] == true) {
                            lockStep++;
                            codeEntered = 1;
                        }
                        

                        if (codeEntered > 7){
                            codeEntered = 0;
                        }

                        codeEntered++;
                        angle += 45;
                        lockSlot.localEulerAngles = new Vector3(0, 180, angle);


                    } else if (Input.GetKeyDown(KeyCode.LeftArrow) || Input.GetKeyDown(KeyCode.A)) {
                        if (lockStep == 0 && safeMatch[lockStep] == true) {
                            lockStep++;
                            codeEntered = 0;
                        }
                        
                        if (lockStep != 1 || codeEntered > 7) {
                            codeEntered = 0;
                            lockStep = 0;
                        }
                        
                        codeEntered++;
                        angle -= 45;
                        lockSlot.localEulerAngles = new Vector3(0, 180, angle);
                        
                    } else if (Input.GetKeyDown(KeyCode.UpArrow) || Input.GetKeyDown(KeyCode.W)){
                        ResetSafeLock();
                    }
                }
            } else {
                if (Input.GetKeyDown(KeyCode.UpArrow) || Input.GetKeyDown(KeyCode.W)) {
                    GameController.UnPauseGame();
                    doorLock.OpenDoor();
                    gameObject.SetActive(false);
                    if (safe) {
                        player.bag = true;
                    }
                }
            }
        }
    }

    private void ResetSafeLock() {
        lockSlot.localEulerAngles = new Vector3(0, 180, 0);
        angle = 0;
        codeEntered = 0;
        lockStep = 0;
    }
}
