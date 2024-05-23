using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class EnemyController : MonoBehaviour
{
    public bool facingRight = true;
    public float speed = 3f;
    public bool alert = false;
    
    private float enemyMove;

    public CopDetector[] cops;
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
        cops = GameObject.FindObjectsOfType<CopDetector>();
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        if ((detectorLeft.detected == true || detectorRight.detected == true) && alert == false) {
            if (alert == false) {
                audioSource.Play();
            }
            animator.SetBool("Alert", true);
            speed = speed * 3;
            for (int i = 0; i < cops.Length; i++){
                if (cops[i].detected == false) {
                    cops[i].detected = true;
                }
            }
            alert = true;
        }

        enemyMove = speed * Time.deltaTime;
        animator.SetFloat("Speed", enemyMove);
        transform.Translate(new Vector3(enemyMove, 0, 0));
    }

    private void Update() {
        DirectionCheck();
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

    private void OnTriggerEnter2D(Collider2D other) {
        if (alert) {
            if (other.gameObject.tag == "Player") {
                SceneManager.LoadScene("Loose");
            }
        }
        
    }
}
