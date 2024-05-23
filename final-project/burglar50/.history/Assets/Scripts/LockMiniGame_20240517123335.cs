using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LockMiniGame : MonoBehaviour
{
    public bool safe = false;
    private int[] passcode = new int[3];
    private int codeEntered = 0;
    private int digit;

    public GameObject lockSlot;
    public GameObject lockPick;

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
    }

    // Update is called once per frame
    void Update()
    {
        if (!safe){
            if (Input.GetKey(KeyCode.UpArrow) || Input.GetKey(KeyCode.W)) {
                if (codeEntered < 3){
                    codeEntered = codeEntered++;
                    lockSlot.transform.Translate(new Vector3(0, 0, 0.35f));
                }   
            } else if (Input.GetKey(KeyCode.DownArrow) || Input.GetKey(KeyCode.S)) {
                if (codeEntered > 0){
                    codeEntered = codeEntered--;
                }
            } else if (Input.GetKey(KeyCode.RightArrow) || Input.GetKey(KeyCode.D)){


            }
        }
    }
}
