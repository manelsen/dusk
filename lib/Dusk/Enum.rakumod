use v6.d;

# Discord API v10 Enums
unit module Dusk::Enum;

# Activity Types
enum ActivityType is export (
    Game => 0,
    ActivityTypeStreaming => 1,
    Listening => 2,
    Watching => 3,
    Custom => 4,
    Competing => 5,
);

# Channel Types
enum ChannelType is export (
    GuildText => 0,
    DM => 1,
    GuildVoice => 2,
    GroupDM => 3,
    GuildCategory => 4,
    GuildNews => 5,
    GuildNewsThread => 10,
    GuildPublicThread => 11,
    GuildPrivateThread => 12,
    GuildStageVoice => 13,
);

# Message Flags
enum MessageFlags is export (
    Crossposted => 1,
    IsCrosspost => 2,
    SuppressEmbeds => 4,
    SourceMessageDeleted => 8,
    Urgent => 16,
    HasThread => 32,
    Ephemeral => 64,
    Loading => 128,
    FailedToMention => 256,
    SuppressNotifications => 4096,
    IsVoiceMessage => 8192,
);

# Permission Flags
enum Permission is export (
    CreateInstantInvite => 1,
    KickMembers => 2,
    BanMembers => 4,
    Administrator => 8,
    ManageChannels => 16,
    ManageGuild => 32,
    AddReactions => 64,
    ViewAuditLog => 128,
    PrioritySpeaker => 256,
    Stream => 512,
    ReadMessages => 1024,
    SendMessages => 2048,
    SendTTSMessages => 4096,
    ManageMessages => 8192,
    EmbedLinks => 16384,
    AttachFiles => 32768,
    ReadMessageHistory => 65536,
    MentionEveryone => 131072,
    UseExternalEmojis => 262144,
    ViewGuild => 1048576,
    Connect => 1048576,
    Speak => 2097152,
    MuteMembers => 4194304,
    DeafenMembers => 8388608,
    MoveMembers => 16777216,
    UseVAD => 33554432,
    ChangeNickname => 67108864,
    ManageNicknames => 134217728,
    ManageRoles => 268435456,
    ManageWebhooks => 536870912,
    ManageEmojis => 1073741824,
    UseSlashCommands => 2147483648,
    RequestToSpeak => 4294967296,
    ManageThreads => 8589934592,
    CreatePublicThreads => 17179869184,
    CreatePrivateThreads => 34359738368,
    UseExternalStickers => 68719476736,
    SendMessagesInThreads => 137438953472,
    StartEmbeddedActivities => 274877906944,
    ModerateMembers => 549755813888,
);

# Verification Level
enum VerificationLevel is export (
    VerificationLevelNone => 0,
    Low => 1,
    Medium => 2,
    High => 3,
    VeryHigh => 4,
);

# Default Message Notification Level
enum DefaultMessageNotificationLevel is export (
    AllMessages => 0,
    OnlyMentions => 1,
);

# Explicit Content Filter Level
enum ExplicitContentFilterLevel is export (
    Disabled => 0,
    MembersWithoutRoles => 1,
    AllMembers => 2,
);

# MFA Level
enum MFALevel is export (
    MFALevelNone => 0,
    Elevated => 1,
);

# Premium Tier
enum PremiumTier is export (
    PremiumTierNone => 0,
    Tier1 => 1,
    Tier2 => 2,
    Tier3 => 3,
);

# Premium Type
enum PremiumType is export (
    PremiumTypeNone => 0,
    NitroClassic => 1,
    Nitro => 2,
);

# System Channel Flags
enum SystemChannelFlags is export (
    SuppressJoinNotifications => 1,
    SuppressPremiumSubscriptions => 2,
    SuppressGuildReminderNotifications => 4,
    SuppressJoinNotificationReplies => 8,
    SuppressRoleSubscriptionPurchaseNotifications => 16,
);

# User Flags
enum UserFlags is export (
    DiscordEmployee => 1,
    PartneredServerOwner => 2,
    HypeSquadEvents => 4,
    BugHunterLevel1 => 8,
    HouseBravery => 64,
    HouseBrilliance => 128,
    HouseBalance => 256,
    EarlySupporter => 512,
    TeamPseudoUser => 1024,
    BugHunterLevel2 => 16384,
    VerifiedBot => 65536,
    EarlyVerifiedBotDeveloper => 131072,
    DiscordCertifiedModerator => 262144,
    BotHTTPInteractions => 524288,
);

# Presence Status
enum PresenceStatus is export (
    Online => 'online',
    Idle => 'idle',
    Dnd => 'dnd',
    Invisible => 'invisible',
    Offline => 'offline',
);

# Overwrite Type
enum OverwriteType is export (
    Role => 0,
    Member => 1,
);

# Invite Target Type
enum InviteTargetType is export (
    InviteTargetTypeStream => 1,
    EmbeddedApplication => 2,
);

# Scheduled Event Status
enum ScheduledEventStatus is export (
    Scheduled => 1,
    Active => 2,
    Completed => 3,
    Canceled => 4,
);

# Scheduled Event Entity Type
enum ScheduledEventEntityType is export (
    StageInstance => 1,
    Voice => 2,
    External => 3,
);

# Stage Instance Privacy Level
enum StageInstancePrivacyLevel is export (
    Public => 1,
    GuildOnly => 2,
);

# Entitlement Type
enum EntitlementType is export (
    Purchase => 1,
    PremiumSubscription => 2,
    DeveloperGift => 3,
    TestModePurchase => 5,
    TestModeSubscriptionGift => 6,
    PremiumPurchase => 8,
);

# Sticker Format Type
enum StickerFormatType is export (
    PNG => 1,
    APNG => 2,
    Lottie => 3,
);

# Auto Moderation Event Type
enum AutoModEventType is export (
    MessageSend => 1,
);

# Auto Moderation Trigger Type
enum AutoModTriggerType is export (
    Keyword => 1,
    Spam => 3,
    KeywordPreset => 4,
    MentionSpam => 5,
);

# Auto Moderation Action Type
enum AutoModActionType is export (
    BlockMessage => 1,
    SendAlertMessage => 2,
    Timeout => 3,
    BlockMemberInteraction => 4,
);

# Audit Log Action Types
enum AuditLogActionType is export (
    GuildUpdate => 1,
    ChannelCreate => 10,
    ChannelUpdate => 11,
    ChannelDelete => 12,
    ChannelOverwriteCreate => 13,
    ChannelOverwriteUpdate => 14,
    ChannelOverwriteDelete => 15,
    MemberKick => 20,
    MemberPrune => 21,
    MemberBanAdd => 22,
    MemberBanRemove => 23,
    MemberUpdate => 24,
    MemberRoleUpdate => 25,
    MemberMove => 26,
    MemberDisconnect => 27,
    BotAdd => 28,
    RoleCreate => 30,
    RoleUpdate => 31,
    RoleDelete => 32,
    InviteCreate => 40,
    InviteUpdate => 41,
    InviteDelete => 42,
    WebhookCreate => 50,
    WebhookUpdate => 51,
    WebhookDelete => 52,
    EmojiCreate => 60,
    EmojiUpdate => 61,
    EmojiDelete => 62,
    MessageDelete => 72,
    MessageBulkDelete => 73,
    MessagePin => 74,
    MessageUnpin => 75,
    IntegrationCreate => 80,
    IntegrationUpdate => 81,
    IntegrationDelete => 82,
    StageInstanceCreate => 83,
    StageInstanceUpdate => 84,
    StageInstanceDelete => 85,
    StickerCreate => 90,
    StickerUpdate => 91,
    StickerDelete => 92,
    EventCreate => 100,
    EventUpdate => 101,
    EventDelete => 102,
    ThreadCreate => 110,
    ThreadUpdate => 111,
    ThreadDelete => 112,
    ApplicationCommandPermissionUpdate => 121,
    AutoModRuleCreate => 140,
    AutoModRuleUpdate => 141,
    AutoModRuleDelete => 142,
    AutoModMessageBlock => 143,
    AutoModFlagToChannel => 144,
    AutoModUserCommunicationDisabled => 145,
    CreatorMonetizationRequestCreate => 150,
    CreatorMonetizationTermsAccepted => 151,
    OnboardingPromptCreate => 163,
    OnboardingPromptUpdate => 164,
    OnboardingPromptDelete => 165,
    OnboardingCompletion => 166,
);

# Guild Features
enum GuildFeature is export (
    AnimatedBanner => 'ANIMATED_BANNER',
    AnimatedIcon => 'ANIMATED_ICON',
    AutoModeration => 'AUTO_MODERATION',
    Banner => 'BANNER',
    Community => 'COMMUNITY',
    Discoverable => 'DISCOVERABLE',
    Featurable => 'FEATURABLE',
    InviteSplash => 'INVITE_SPLASH',
    MemberVerificationGate => 'MEMBER_VERIFICATION_GATE_ENABLED',
    Monetization => 'MONETIZATION_ENABLED',
    MoreStickers => 'MORE_STICKERS',
    News => 'NEWS',
    Partnered => 'PARTNERED',
    PreviewEnabled => 'PREVIEW_ENABLED',
    PrivateThreads => 'PRIVATE_THREADS',
    RoleIcons => 'ROLE_ICONS',
    TicketedEvents => 'TICKETED_EVENTS_ENABLED',
    VanityURL => 'VANITY_URL',
    Verified => 'VERIFIED',
    VipRegions => 'VIP_REGIONS',
    WelcomeScreen => 'WELCOME_SCREEN_ENABLED',
);
