using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyController : MonoBehaviour
{
    public bool facingRight = true;
    public float speed = 5f;
    public bool alert;
    
    private float enemyMove;

    public Collider2D detector;
    public PlayerController playerController = null;
    public Animator animator;
    

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        DirectionCheck();

    }

    void DirectionCheck(){
        if(enemyMove > 0.01){
            facingRight = true;
        } else if(enemyMove < -0.01){
            facingRight = false;
        }

        animator.SetBool("Facing_Right", facingRight);
    }
}
