variable "operation_id" {
  type = string
}

variable "operation_id" {
  type = string
}

variable "api_name" {
  type = string
}

variable "api_management_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "display_name" {
  type = string
}

variable "method" {
  type = string
}

variable "url_template" {
  type = string
}

variable "description" {
  type = string
}

variable "request" {
  type = set(object({
    description = optional(string, null)

    header = optional(set(object({
        name = string
        required = bool
        type = string
        description = optional(string, null)
        default_value = optional(string, null)
        values = optional(list(string), [])

        example = optional(set(object({
            name = string
            summary = optional(string, null)
            description = optional(string, null)
            value = optional(string, null)
            external_value = optional(string, null)
        })), [])

        schema_id = optional(string, null)
        type_name = optional(string, null)
    })), [])

    query_parameter = optional(set(object({
        name = string
        required = bool
        type = string
        description = optional(string, null)
        default_value = optional(string, null)
        values = optional(list(string), [])

        example = optional(set(object({
            name = string
            summary = optional(string, null)
            description = optional(string, null)
            value = optional(string, null)
            external_value = optional(string, null)
        })), [])

        schema_id = optional(string, null)
        type_name = optional(string, null)
        
    })), [])

    representation = optional(set(object({
        content_type = string
        form_parameter = optional(set(object({
            name = string
            required = bool
            type = string
            description = optional(string, null)
            default_value = optional(string, null)
            values = optional(list(string), [])

            example = optional(set(object({
                 name = string
                 summary = optional(string, null)
                 description = optional(string, null)
                 value = optional(string, null)
                 external_value = optional(string, null)
             })), [])

            schema_id = optional(string, null)
            type_name = optional(string, null)
        })))
        example = optional(set(object({
            name = string
            summary = optional(string, null)
            description = optional(string, null)
            value = optional(string, null)
            external_value = optional(string, null)
        })), [])
        schema_id = optional(string, null)
        type_name = optional(string, null)
    })), [])

  }))
}

variable "response" {
  type = set(object({
    status_code = string
    description = optional(string, null)
    header = optional(set(object({
        name = string
        required = bool
        type = string
        description = optional(string, null)
        default_value = optional(string, null)
        values = optional(list(string), [])

        example = optional(set(object({
            name = string
            summary = optional(string, null)
            description = optional(string, null)
            value = optional(string, null)
            external_value = optional(string, null)
        })), [])

        schema_id = optional(string, null)
        type_name = optional(string, null)
    })), [])
    representation = optional(set(object({
        content_type = string
        form_parameter = optional(set(object({
            name = string
            required = bool
            type = string
            description = optional(string, null)
            default_value = optional(string, null)
            values = optional(list(string), [])

            example = optional(set(object({
                 name = string
                 summary = optional(string, null)
                 description = optional(string, null)
                 value = optional(string, null)
                 external_value = optional(string, null)
             })), [])

            schema_id = optional(string, null)
            type_name = optional(string, null)
        })))
        example = optional(set(object({
            name = string
            summary = optional(string, null)
            description = optional(string, null)
            value = optional(string, null)
            external_value = optional(string, null)
        })), [])
        schema_id = optional(string, null)
        type_name = optional(string, null)
    })), [])

  }))
}

variable "template_parameter" {
  type = set(object({
    name = string
        required = bool
        type = string
        description = optional(string, null)
        default_value = optional(string, null)
        values = optional(list(string), [])

        example = optional(set(object({
            name = string
            summary = optional(string, null)
            description = optional(string, null)
            value = optional(string, null)
            external_value = optional(string, null)
        })), [])

        schema_id = optional(string, null)
        type_name = optional(string, null)
  }), [])
}
