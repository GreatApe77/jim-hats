import { IUser } from "../../src/users/IUser";

export const mockUsers: IUser[] = [
    {
        id: 1,
        username: 'john_doe',
        email: 'john@example.com',
        password: 'securepassword1',
        profilePicture: 'john_profile.jpg',
        createdAt: new Date('2023-01-01T10:00:00Z'),
        updatedAt: new Date('2023-06-01T10:00:00Z')
    },
    {
        id: 2,
        username: 'jane_smith',
        email: 'jane@example.com',
        password: 'securepassword2',
        profilePicture: 'jane_profile.jpg',
        createdAt: new Date('2023-02-01T11:00:00Z'),
        updatedAt: new Date('2023-06-02T11:00:00Z')
    },
    {
        id: 3,
        username: 'bob_jones',
        email: 'bob@example.com',
        password: 'securepassword3',
        profilePicture: null,
        createdAt: new Date('2023-03-01T12:00:00Z'),
        updatedAt: new Date('2023-06-03T12:00:00Z')
    }
];