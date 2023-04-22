swagger: "2.0"
info:
  version: "1.0.0"
  title: "Comments API"
  description: "API for managing comments"
basePath: "/api"
schemes:
  - "http"
consumes:
  - "application/json"
produces:
  - "application/json"

securityDefinitions:
  bearerAuth:
    type: apiKey
    name: Authorization
    in: header

definitions:
  Comment:
    type: object
    properties:
      text:
        type: string
      author:
        type: object
        properties:
          id:
            type: integer
          name:
            type: string
      post:
        type: object
        properties:
          id:
            type: integer
          title:
            type: string
          body:
            type: string

paths:
  /posts/{post_id}/comments:
    get:
      tags:
        - "Comments"
      description: "Returns all comments for a post"
      operationId: "getCommentsByPostId"
      parameters:
        - name: "post_id"
          in: "path"
          description: "ID of the post to get comments for"
          required: true
          type: "integer"
      responses:
        200:
          description: "Comments for the post"
          schema:
            type: "array"
            items:
              $ref: "#/definitions/Comment"
        401:
          $ref: "#/responses/Unauthorized"
        403:
          $ref: "#/responses/Forbidden"
        404:
          $ref: "#/responses/NotFound"

    post:
      tags:
        - "Comments"
      description: "Adds a new comment to a post"
      operationId: "addComment"
      parameters:
        - name: "post_id"
          in: "path"
          description: "ID of the post to add the comment to"
          required: true
          type: "integer"
        - name: "comment"
          in: "body"
          description: "Comment object to add"
          required: true
          schema:
            $ref: "#/definitions/Comment"
      responses:
        201:
          description: "Comment added successfully"
          schema:
            $ref: "#/definitions/Comment"
        400:
          $ref: "#/responses/BadRequest"
        401:
          $ref: "#/responses/Unauthorized"
        403:
          $ref: "#/responses/Forbidden"
        404:
          $ref: "#/responses/NotFound"
        422:
          $ref: "#/responses/UnprocessableEntity"

responses:
  Unauthorized:
    description: "Unauthorized"
    schema:
      type: "object"
      properties:
        status:
          type: "string"
          example: "Failure"
        error:
          type: "string"
          example: "Unauthorized"
  Forbidden:
    description: "Forbidden"
    schema:
      type: "object"
      properties:
        status:
          type: "string"
          example: "Failure"
        error:
          type: "string"
          example: "Access Denied"
  NotFound:
    description: "Not Found"
    schema:
      type: "object"
      properties:
        status:
          type: "string"
          example: "Failure"
        error:
          type: "string"
          example: "Record Not Found"
  BadRequest:
    description: "Bad Request"
    schema:
      type: "object"
      properties:
        status:
          type: "string"
          example: "Failure"
        error:
          type: "string"
          example: "Invalid Parameter(s)"

  Unauthorized:
    description: "Unauthorized"
      schema:
      type: "object"
      properties:
      status:
      type: "string"
      example: "Failure"
      error:
      type: "string"
      example: "Invalid authentication token"

  Forbidden:
    description: "Forbidden"
      schema:
      type: "object"
      properties:
      status:
      type: "string"
      example: "Failure"
      error:
      type: "string"
      example: "Access Denied"

  NotFound:
    description: "Not Found"
      schema:
      type: "object"
      properties:
      status:
      type: "string"
      example: "Failure"
      error:
      type: "string"
      example: "Record Not Found"
