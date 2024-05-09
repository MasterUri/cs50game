using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    public bool facingRight = true;
    public bool bag = false;
    public float speed = 10f;

    float playerMove;

    public Animator animator;
    
    // Start is called before the first frame update
    void Start()
    {
        facingRight = true;
        bag = false;
    }

    // Update is called once per frame
    void Update()
    {
        DirectionCheck();

        float moveInput = Input.GetAxis("Horizontal");
        playerMove = moveInput  * speed * Time.deltaTime;
        animator.SetFloat("Speed", playerMove);
        transform.Translate(new Vector3(playerMove, 0, 0));
    }

    void DirectionCheck(){
        if(playerMove > 0.01){
            facingRight = true;
        } else if(playerMove < -0.01){
            facingRight = false;
        }

        animator.SetBool("Facing_Right", facingRight);
    }
}
