swagger: '2.0'
info:
  title: User Registration API
  version: 1.0.0
paths:
  /api/register:
    post:
      tags:
        - Users
      summary: Register a new user
      description: Creates a new user account with the provided information
      consumes:
        - application/json
      produces:
        - application/json
      parameters:
        - in: body
          name: user
          description: The user information to create the new account
          required: true
          schema:
            type: object
            properties:
              name:
                type: string
                description: The name of the user
              email:
                type: string
                format: email
                description: The email address of the user
              password:
                type: string
                description: The password for the new account
      responses:
        '201':
          description: User account created successfully
          schema:
            type: object
            properties:
              id:
                type: integer
                description: The ID of the newly created user account
              name:
                type: string
                description: The name of the user
              email:
                type: string
                format: email
                description: The email address of the user
              created_at:
                type: string
                format: date-time
                description: The date and time the user account was created
              updated_at:
                type: string
                format: date-time
                description: The date and time the user account was last updated
        '422':
          description: Invalid request or validation error
          schema:
            type: object
            properties:
              errors:
                type: array
                items:
                  type: string
                description: Array of error messages indicating what went wrong
