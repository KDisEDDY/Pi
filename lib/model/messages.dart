class Messages {
        final String role;
        final String content;
        const Messages({
            required this.role,
            required this.content
        });

        factory Messages.fromJson(Map<String, dynamic> json) {
            return Messages(
                role: json['role'] as String,
                content: json['content'] as String
            );
        }

        Map<String, dynamic> toJson() => {
            'role': role,
            'content':content
        };
        }   