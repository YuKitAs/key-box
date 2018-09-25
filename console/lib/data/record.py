import json


class Record:
    def __init__(self, name, description, url, user, key):
        self.__name = name
        self.__description = description
        self.__url = url
        self.__user = user
        self.__key = key

    @property
    def name(self):
        return self.__name

    @property
    def description(self):
        return self.__description

    @property
    def url(self):
        return self.__url

    @property
    def user(self):
        return self.__user

    @property
    def key(self):
        return self.__key

    def to_json(self):
        return json.dumps({
          "name": self.name,
          "description": self.description,
          "url": self.url,
          "user": self.user,
          "key": self.key
        })

    @staticmethod
    def from_json(json_string):
        json_data = json.loads(json_string)
        return Record(
            name=json_data["name"],
            description=json_data["description"],
            url=json_data["url"],
            user=json_data["user"],
            key=json_data["key"]
        )
