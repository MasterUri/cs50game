using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CopDetector : MonoBehaviour
{
    public bool detected = false;

    private void OnCollisionEnter2D(Collision2D other) {
        if (other.gameObject.tag == "Player") {
            if (!other.gameObject.GetComponent<PlayerController>().hidden) {
                detected = true;
            }
        }
    }
}
