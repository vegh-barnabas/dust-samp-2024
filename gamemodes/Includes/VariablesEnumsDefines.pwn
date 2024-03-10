#define Server:%0(%1) forward %0(%1); public %0(%1)

#define MYSQL_HOST "localhost"
#define MYSQL_USER "basic-rp"
#define MYSQL_DATABASE "basic-rp"
#define MYSQL_PASSWORD "basicRoleplay"

#define COLOR_WHITE     0xFFFFFF00
#define COLOR_RED       0xFF000000
#define COLOR_YELLOW    0xFFFF0000
#define COLOR_EMOTE     0xEDA4FF00
#define COLOR_SHOUT     0xD1692C00
#define	COLOR_SERVER    0x6533B500
#define	COLOR_ADMIN     0x3744B300
#define COLOR_USAGE     0xBF6C1900
#define COLOR_RED2      0xF8141400
#define COLOR_GREEN     0x6AA84F00
#define COLOR_LORANGE   0xf6B26B00
#define COLOR_LIGHTBLUE 0x3333FF00

#define DIALOG_UNUSED		0
#define DIALOG_REGISTER		1
#define	DIALOG_LOGIN		2

#define VERSION_TEXT	"1.0"

#define DEFAULT_SKIN		60

#define MAX_DAMAGES				(MAX_PLAYERS * 10)
#define MAX_HOUSES				50
#define MAX_OWNED_VEHICLES		3
#define MAX_BUSINESSES			40
#define MAX_TEMP_VEHICLES		30
#define MAX_RENTABLE_VEHICLES   20

#define BODY_PART_CHEST			3
#define BODY_PART_TORSO			4
#define BODY_PART_LEFT_ARM		5
#define BODY_PART_RIGHT_ARM		6
#define BODY_PART_LEFT_LEG		7
#define BODY_PART_RIGHT_LEG		8
#define BODY_PART_HEAD			9

#define MESSAGE_TYPE_SERVER     0
#define MESSAGE_TYPE_ADMIN      1
#define MESSAGE_TYPE_USAGE      2
#define MESSAGE_TYPE_ERROR      3
#define MESSAGE_TYPE_SUCCESS	4

#define BUSINESS_TYPE_SHOP          1
#define BUSINESS_TYPE_DEALERSHIP    2

#define INTERIOR_GROCERIES_1        17
#define INTERIOR_GROCERIES_2        10
#define INTERIOR_CASINO             12
#define INTERIOR_CLOTHES_BINCO      15

#define MAX_BUSINESS_INTERIORS      5 // don't forget to resize this if the list gets modified

#define PICKUP_INFO             1239
#define PICKUP_BLUE_HOUSE       1272
#define PICKUP_GREEN_HOUSE      1273
#define PICKUP_DOLLAR           1274
#define PICKUP_SHIRT            1275

#define LOG_TYPE_UNDEFINED      0
#define LOG_TYPE_PURCHASE       1
#define WEATHER_TYPE_UNKNOWN        0
#define WEATHER_TYPE_SUNNY          1
#define WEATHER_TYPE_EXTRASUNNY     2
#define WEATHER_TYPE_CLOUDY         3
#define WEATHER_TYPE_RAINY          4
#define WEATHER_TYPE_FOGGY          5
#define WEATHER_TYPE_SANDSTORM      6


// AddPlayerClass(60, -28.3890, -89.9544, 1003.5469, 182.2708, 0, 0, 0, 0, 0, 0); // /buy location 24/7-3

enum PLAYER_DATA
{
    pSQLID,
    pAdminLevel,
    pMoney,
    pLevel,
    pRespect,
    Float:pLastPos[5],
    pLastInt,
    pLastWorld
}

enum DAMAGE_DATA
{
    DamagePlayerID,
    WEAPON:DamageWeapon,
    Float:DamageAmount,
    DamageBodyPart
}

enum HOUSE_DATA
{
    HouseID,
    HouseOwnerSQL,
    HouseName[40],
    Float:HouseExterior[4],
    Float:HouseInterior[4],
    HouseInteriorID,
    HousePrice,
    HouseLocked,
    HousePickup,
    Text3D:HouseLabel
}

enum OWNED_CAR_DATA
{
    OwnedCarID,
    OwnedCarOwner,
    OwnedCarLock,
    OwnedCarModel,
    OwnedCarColor[2],
    Float:OwnedCarPos[4],
    OwnedCarPlate[10]
}

enum BUSINESS_DATA
{
    BusinessID,
    BusinessOwnerSQL,
    BusinessName[40],
    Float:BusinessExterior[4],
    BusinessInterior,
    BusinessType,
    BusinessPrice,
    BusinessLocked,
    BusinessPickup,
    Text3D:BusinessLabel
}

enum TEMP_VEHICLE_DATA
{
    TempVehicleID,
    Text3D:TempVehicle3DText,
    TempVehicleSpawnerSQLID
}


// Global variables
new MySQL:sqlConnection;
new OneSecondTimer, lastSaveTime = 0;

// Player variables
new bool:LoggedIn[MAX_PLAYERS], PlayerData[MAX_PLAYERS][PLAYER_DATA], DamageData[MAX_DAMAGES][DAMAGE_DATA], totalDamages = 0;

new fiveMinuteTimer[MAX_PLAYERS];

// House variables
new HouseData[MAX_HOUSES][HOUSE_DATA], totalHousesCreated = 0;

// Car variables
new OwnedCarData[MAX_VEHICLES][OWNED_CAR_DATA];

// Temporary vehicle variables
new TempVehicleData[MAX_TEMP_VEHICLES][TEMP_VEHICLE_DATA];
new totalTempVehicles = 0;

// Business variables
new BusinessData[MAX_BUSINESSES][BUSINESS_DATA];
new totalBusinessesCreated = 0;