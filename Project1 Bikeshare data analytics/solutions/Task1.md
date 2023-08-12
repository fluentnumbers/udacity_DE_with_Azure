- [Task 1: Create your Azure resources](#task-1-create-your-azure-resources)
  - [Create an Azure Database for PostgreSQL](#create-an-azure-database-for-postgresql)
  - [Create an Azure Synapse workspace](#create-an-azure-synapse-workspace)
  - [Creat a Blob Storage](#creat-a-blob-storage)
- [ | Task 2](#--task-2)

# [Task 1: Create your Azure resources](../Project%20Instructions.md#task-1--create-your-azure-resources)

## Create an Azure Database for PostgreSQL
Go to **Resources**, select **Azure Database for PostgreSQL** and create.
<img src="../assets/2023-08-12 13_09_28-Clipboard.png" width="700"/>


On the next page pick **Flexible server** and click Create.

Then set the server settings (cheapest workload):
<img src="..\assets\2023-08-12 13_15_49-Clipboard.png" width="700"/>

Allow public access in Networking settings:
<img src="..\assets\2023-08-12 13_17_53-Clipboard.png" width="700"/>

Click **Next** until you can actually create the resource.

## Create an Azure Synapse workspace
Among resources to create find **Azure Synapse Analytics**. Create.
In basic settings select the same resource group as for the database before. Create new Account name and File system name if needed.

<img src="..\assets\2023-08-12 13_26_32-.png" width="700"/>

on the next screen provide SQL username and password to connect to preciously created PostGres server. Everything else by default.

<img src="..\assets\image.png" width="700"/>

Go further and create the resource.

## Creat a Blob Storage
Create a **Storage account** for the same resource group.
<img src="../assets/2023-08-12%2014_32_59-.png" width="700"/>



# []() | [Task 2](./Task2.md)
