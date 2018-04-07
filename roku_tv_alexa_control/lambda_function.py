import boto3

access_key = "<access_key>"
access_secret = "<Super_Secret>"
region ="us-east-2"
queue_url = "https://sqs.us-east-2.amazonaws.com/<id>/account"



def build_speechlet_response(title, output, reprompt_text, should_end_session):
    return {
        'outputSpeech': {
            'type': 'PlainText',
            'text': output
        },
        'card': {
            'type': 'Simple',
            'title': "SessionSpeechlet - " + title,
            'content': "SessionSpeechlet - " + output
        },
        'reprompt': {
            'outputSpeech': {
                'type': 'PlainText',
                'text': reprompt_text
            }
        },
        'shouldEndSession': should_end_session
    }

def build_response(session_attributes, speechlet_response):
    return {
        'version': '1.0',
        'sessionAttributes': session_attributes,
        'response': speechlet_response
    }

def post_message(client, message_body, url):
    response = client.send_message(QueueUrl = url, MessageBody= message_body)

def lambda_handler(event, context):
    client = boto3.client('sqs', aws_access_key_id = access_key, aws_secret_access_key = access_secret, region_name = region)
    intent_name = event['request']['intent']['name']
    if intent_name == "TvPower":
        post_message(client, 'initiating power control', queue_url)
        message = "powerButton"
    elif intent_name == "CalendarOn":
        post_message(client, 'turning calendar display on', queue_url)
        message = "hdmiOn"
    elif intent_name == "CalendarOff":
        post_message(client, 'turning calendar display off', queue_url)
        message = "hdmiOff"
    elif intent_name == "ForceOff":
        post_message(client, 'shutting the calendar off', queue_url)
        message = "down"
    elif intent_name == "ForceCycle":
        post_message(client, 'rebooting the calendar', queue_url)
        message = "reboot"
    else:
        message = "Unknown"

    speechlet = build_speechlet_response("Calendar Status", message, "", "true")
    return build_response({}, speechlet)
