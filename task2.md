Task 2: Push Notifications

Let's define three objects:
1. user
2. message
3. notify (boolean)

with user:
user.status
user.state
user.push_tokens

with message:
message.state
message.content

with idle:
15 minutes

There are three possible conditions:
1. message.state = 'pending' if user.state == 'online' and user.status != 'idle'

  Test:
    if user.state = active and user.status != idle
      assert message.state == 'pending'
      assert pre-message.content is equal to the post-message.content pushed.
      assert notify == false


2. message.state = 'pushed' if user.state == 'online' or user.status == 'idle'

  Test:
    if user.state == 'online' or user.status == 'idle'
      assert message.state == 'pushed'
      assert notify == true
      assert pre-message.content is equal to post-message.content pushed.
      assert notify count == user.push_tokens count

3. message.state = 'pushed' if user.state == 'offline' or user.status == 'idle'

  Test:
    if user.state == 'offline' or user.status == 'idle'
      assert message.state == 'pushed'
      assert notify == true
      assert pre-message.content is equal to post-message.content pushed.
      assert notify count == user.push_tokens count

Flow:
  1. Send message
  2. Save the message.content into a pre-message variable
  3. api GET users/:id to get the user object
  4. Run the assertions written above based on the user's state and status.



