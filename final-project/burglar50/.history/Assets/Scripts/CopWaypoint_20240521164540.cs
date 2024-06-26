using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CopWaypoint : MonoBehaviour
{
    private void OnCollisionEnter2D(Collision2D other) {
        if (other.gameObject.tag == "Enemy") {
            if (other.gameObject.GetComponent<EnemyController>().alert == false){
                other.gameObject.GetComponent<EnemyController>().facingRight = !other.gameObject.GetComponent<EnemyController>().facingRight;
            }
        }
    }
}
