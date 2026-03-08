use v6.d;
use Test;
use Dusk::Enum;

plan 20;

# Activity Types
ok ActivityType::Game == 0, 'ActivityType::Game equals 0';
ok ActivityType::ActivityTypeStreaming == 1, 'ActivityType::Streaming equals 1';
ok ActivityType::Listening == 2, 'ActivityType::Listening equals 2';

# Channel Types
ok ChannelType::GuildText == 0, 'ChannelType::GuildText is 0';
ok ChannelType::DM == 1, 'ChannelType::DM is 1';
ok ChannelType::GuildVoice == 2, 'ChannelType::GuildVoice is 2';

# Message Flags
ok MessageFlags::Crossposted == 1, 'MessageFlags::Crossposted is 1';
ok MessageFlags::Ephemeral == 64, 'MessageFlags::Ephemeral is 64';
ok MessageFlags::SuppressNotifications == 4096, 'MessageFlags::SuppressNotifications is 4096';

# Permission Flags
ok Permission::CreateInstantInvite == 1, 'Permission::CreateInstantInvite is 1';
ok Permission::Administrator == 8, 'Permission::Administrator is 8';
ok Permission::BanMembers == 4, 'Permission::BanMembers is 4';
ok Permission::ManageMessages == 8192, 'Permission::ManageMessages is 8192';

# Verification Level
ok VerificationLevel::VerificationLevelNone == 0, 'VerificationLevel::None is 0';
ok VerificationLevel::High == 3, 'VerificationLevel::High is 3';

# Presence Status
ok PresenceStatus::Online eq 'online', 'PresenceStatus::Online is online';
ok PresenceStatus::Idle eq 'idle', 'PresenceStatus::Idle is idle';
ok PresenceStatus::Dnd eq 'dnd', 'PresenceStatus::Dnd is dnd';

# Invite Target Type
ok InviteTargetType::InviteTargetTypeStream == 1, 'InviteTargetType::Stream is 1';
ok InviteTargetType::EmbeddedApplication == 2, 'InviteTargetType::Embedded is 2';

say "✅ All enum tests passed!";
