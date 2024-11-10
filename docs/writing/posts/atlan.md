---
date: 2024-11-09
categories:
    - Interview
slug: atlan-interview-process
readtime: 10
authors:
  - hk
    
---

![Atlan logo](../images/atlan.png)

## My Journey to Atlan: An Interview Experience

> this is post the OA and the screening round.

### Take Home Assignment

The unique hiring process of the Atlan, validates its candidates on the technical expertise and understanding of the systems and not just the DSA like FAANG. I was given the task of designing and building a highly scalable logistics platform for goods transportation. This platform would allow users to book transportation services, connecting them with a fleet of drivers and offering real-time availability, pricing, and vehicle tracking, over a week of time.

After a week of submission recieved a mail, we loved your solution and moving forward with your applicaiton.

<!-- more -->

### Technical Interview

The interview began with a senior software engineer who introduced himself and explained that another interviewer would join us in about 15 minutes. After our introductions, we dove straight into the high-level design (HLD) discussion of the take home assignment.

#### Key Questions and Challenges
During the HLD, I encountered a few questions that required careful thought:
- **Why both a load balancer and an API gateway?**
- **Using Redis, a key-value store, as a queue – how does that work?**

On a positive note, I was able to answer some questions well:
- **Why not use WebSockets for two-way communication in this case?**
  - I explained that, for this specific application, polling would be more efficient than WebSockets.

After around 20 minutes discussing the HLD, we moved on to a coding question: **find the largest palindromic number that can be achieved by the product of two 3-digit numbers.**

#### Coding Question
I started by explaining a brute-force approach and began coding. However, I initially stumbled when structuring the code into a function and accidentally forgot to join the reversed object after converting it to a list. Fortunately, the interviewers helped me debug, and I managed to complete the solution.

The last 15 minutes involved discussing:
- **Data governance** and internal processes
- **AI integrations** they were building to boost productivity and improve client interactions

I also shared my experience with my marketing agent workflow, which seemed to resonate well with them. The conversation wrapped up on a positive note, and I sent a thank-you email to the recruiter afterward. Now, I'm awaiting the results and hoping for a call for the next round—fingers crossed.

---

### Cultural Round

The cultural round kicked off with introductions. The interviewer shared his background, including his role, college, and journey. He asked me to share my story, starting from childhood, and to reflect on how my journey has shaped me.

We discussed my college experiences, remote working with **AutoGen, VEnable AI, and ForgeWize**, and my ability to work independently. Things were going well, although, midway, I sensed a slight shift in his interest as he checked his phone occasionally, which felt a bit off-putting.

One insightful question he asked was:
- **If I were to call the founders of the startups you worked with previously, what’s one pro and one con they might mention about you?**

When he invited me to ask questions, I did, and we concluded the meeting. Despite the minor interruptions, I felt the cultural round went well. I’m hopeful for a positive outcome but know that whatever happens, this has been a valuable learning experience.

---

### The Result

I finally received a call from the recruiter: I got selected! I’ll be heading to Delhi next month for onboarding week. This experience has been a rollercoaster. I was feeling quite down, seeing my peers from college landing MNC roles, but I’m thrilled to be joining **Atlan**. This journey taught me resilience and the importance of perseverance in the face of setbacks.
