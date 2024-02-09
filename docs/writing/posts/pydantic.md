---
date: 2024-01-30
categories:
    - LLMs
    - AI
slug: all-you-need-is-pydantic
readtime: 12
authors:
  - Hrushikesh Dokala
    
---

# all you need is pydantic

Hey there, language enthusiasts! Ever wondered about the dynamic duo of Pydantic and the OpenAI instructor library? Well, you’re in for a treat. This blog is your ticket to exploring how these two pals can tag-team to make your language model interactions not just effective but downright awesome. Join me as we uncover the magic of combining Pydantic’s finesse with the OpenAI instructor library’s wizardry for a seamless and efficient NLP journey.

## Purpose

Why are we diving into this combo, you ask?

Simple. Pydantic and the OpenAI instructor library aren’t just tools; they’re superheroes in the world of language processing. Together, they form a powerhouse that not only prompts models like a champ but also ensures the responses are top-notch and well-behaved. This blog? It’s your guide to making this dynamic duo work wonders. Perfect for developers and language lovers who want to make their NLP game strong!

## Brief

Before we jump into the fun stuff, let me give you the lowdown on Pydantic and the instructor library.

<b>Pydantic</b>: Think of Pydantic as your data sidekick. It’s this cool open-source library that makes sure your data plays nice and stays organized. No more messy data drama; Pydantic’s got it covered.

<b>Instructor </b>: Now, the instructor library is like the Swiss Army knife for talking to language models. It taps into OpenAI’s API and makes chatting with models a breeze. What’s cool? You use the same tool to ask questions and get answers. Talk about a smooth operator!

```bash
from instructor import patch
from openai import OpenAI
from pydantic import BaseModel

client = patch(OpenAI())

class ScriptModel(BaseModel):
    title: str
    scrpt: int

script = "Once upon a time..."
title = "A Story"

prompt = f"Script: {script}\n Title: {title}"

script= client.chat.completions.create(
    model="gpt-3.5-turbo",
    response_model=ScriptModel,
    messages=[
        {"role": "system", "content": "Write a story for the given script"},
        {"role": "user", "content": prompt},
    ]
)
print(script)
```
the output is now validated by the pydantic, which passes the response through the model and returns the script:

```bash

{
    'script': 'Once upon a time...',
    'title': 'A Story',
    'choices': [
        {
            'message': {
                'role': 'assistant',
                'content': 'In a mystical land far, far away, there was a captivating tale waiting to be told. The script unfolded with a magical atmosphere, and the story was aptly named "A Story." As the plot thickened, the characters embarked on a journey filled with twists and turns, ultimately leading to a surprising and heartwarming conclusion.'
            },
            'finish_reason': 'stop',
            'index': 0
        }
    ]
}
```

## Game

now wonder how can we change the response directly from the llms, just extract the information from the llm and validate through the pydantic model using OpenAISchema from instructor.

```bash
from instructor import patch, OpenAISchema
from pydantic import Field
from openai import OpenAI

client = patch(OpenAI())

class ScreenSegment(OpenAISchema):
  timestamp:str = Field(..., description='Timestamp of the segment')
  script:str = Field(..., description='Script of the segment')

class ScriptModel(OpenAISchema):
  title : str
  scene: List[ScreenSegment] = Field(..., description='List of scenes with timestamp')


prompt = f"Script: {script}\n Title: {title}"

script= client.chat.completions.create(
    model="gpt-3.5-turbo",
    response_model=ScriptModel,
    messages=[
        {"role": "system", "content": "Write a story for the given script"},
        {"role": "user", "content": prompt},
    ]
)
print(script)
```

Hold onto your hats! When we run our script, we get a response that’s more than just words. Here’s the breakdown:

```bash
{
    'title': 'The Enchanted Forest',
    'scene': [
        {
            'timestamp': '00:01:00',
            'script': 'Once upon a time, in a magical land, there was an enchanted forest filled with mystical creatures and ancient trees.'
        },
        {
            'timestamp': '00:05:30',
            'script': 'The sunlight filtered through the leaves, casting a warm glow on the forest floor as the creatures went about their daily activities.'
        },
        {
            'timestamp': '00:10:15',
            'script': 'One day, a brave adventurer entered the forest, seeking the fabled Fountain of Wishes rumored to grant the deepest desires of those who find it.'
        }
        # ... additional segments based on the generated story
    ]
}
```

<b>title</b>: yep, that’s the title of our story, just as we set it in the user prompt.

<b>scene</b>: imagine a list of carefully crafted scenes, each with a timestamp and a script.

It’s like a well-organized party of storytelling goodness. This format? Makes it a breeze to take the model’s creativity and plug it into different applications.

## Conclusion

and there you have it! The magic unfolds when Pydantic and the instructor library team up. They not only make language models sit up and listen but also ensure the responses are neat and ready for action. This blog? Your backstage pass to a smoother, more efficient NLP show. If you’re a developer or just someone who loves playing with words, this combo is your secret weapon.

<b>Please leave your thoughts on this. Thanks</b>

Happy Coding!   