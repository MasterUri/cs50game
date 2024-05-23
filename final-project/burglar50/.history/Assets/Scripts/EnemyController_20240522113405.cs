using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyController : MonoBehaviour
{
    public bool facingRight = true;
    public float speed = 3f;
    public bool alert;
    
    private float enemyMove;

    public GameObject detectionRight;
    public GameObject detectionLeft;
    private CopDetector detectorRight;
    private CopDetector detectorLeft;
    public Transform waypoint1;
    public Transform waypoint2;
    public PlayerController playerController = null;
    public Animator animator;

    private AudioSource audioSource;
    

    // Start is called before the first frame update
    void Start()
    {
        detectorLeft = detectionLeft.GetComponent<CopDetector>();
        detectorRight = detectionRight.GetComponent<CopDetector>();
        audioSource = gameObject.GetComponent<AudioSource>();
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        DirectionCheck();

        if (detectorLeft.detected == true || detectorRight.detected == true) {
            if (alert == false) {
                audioSource.Play();
            }
            alert = true;
            animator.SetBool("Alert", alert);
            speed = 10f;
        }

        enemyMove = speed * Time.deltaTime;
        animator.SetFloat("Speed", enemyMove);
        transform.Translate(new Vector3(enemyMove, 0, 0));
    }

    void DirectionCheck(){
        
        if (gameObject.transform.position.x > waypoint2.position.x ) {
            speed = -speed;
            detectionLeft.SetActive(true);
            detectionRight.SetActive(false);
            facingRight = false;
        } else if (gameObject.transform.position.x < waypoint1.position.x) {
            speed = Mathf.Abs(speed);
            detectionLeft.SetActive(false);
            detectionRight.SetActive(true);
            facingRight = true;
        }

        animator.SetBool("Facing_Right", facingRight);
    }
}
