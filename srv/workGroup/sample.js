const whaterver = {
  ID: "4517906f-1328-4d7c-bd52-d2cafaf7e32b",
  name: "tandem dev group #2",
  description: "test2",
  groupLeader_ID: "12345678-90AB-CDEF-1234-567890ABCDEF",
  project: [
    {
      ID: "95f9fb80-a9c8-4adb-80b5-a30a4afbab65",
      workGroup_ID: "4517906f-1328-4d7c-bd52-d2cafaf7e32b",
      project_ID: "6181c551-cc22-462a-9313-6f33a066bb97",
    },
    {
      ID: "9a585c56-8c22-4380-876c-7106f7967a87",
      workGroup_ID: "4517906f-1328-4d7c-bd52-d2cafaf7e32b",
      project_ID: "eaf7dfc4-6898-4c9c-9632-27db71f6c499",
    },
  ],
  employee: [
    {
      ID: "da3c25db-22fa-4f03-91ee-50e98cda649b",
      workGroup_ID: "4517906f-1328-4d7c-bd52-d2cafaf7e32b",
      employee_ID: "6b64a0d8-a320-4e2f-a847-7e92c0c4b21e",
    },
    {
      ID: "9dd981e4-7fb0-45c6-9714-b260c55f6f61",
      workGroup_ID: "4517906f-1328-4d7c-bd52-d2cafaf7e32b",
      employee_ID: "12345678-90AB-CDEF-1234-567890ABCDEF",
    },
    {
      ID: "09c9ee8d-1860-4e77-a453-5b695622b9d4",
      workGroup_ID: "4517906f-1328-4d7c-bd52-d2cafaf7e32b",
      employee_ID: "12345678-90AB-CDEF-1234-567890ABCDEF",
    },
  ],
};

const employees = whaterver.employee.map((employee) => {
  return console.log(employee.employee_ID);
});
